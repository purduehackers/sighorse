# Sparse Cat Reconstruction from Horse Images (CIFAR-10)

import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import Lasso
from sklearn.preprocessing import StandardScaler
from keras.datasets import cifar10

(x_train, y_train), _ = cifar10.load_data()

horse_images = x_train[y_train.flatten() == 7][:500]
cat_image = x_train[y_train.flatten() == 3][0]

def to_gray(img):
    return np.dot(img[..., :3], [0.299, 0.587, 0.114])

horse_gray = np.array([to_gray(img) for img in horse_images])
horse_flat = horse_gray.reshape((horse_gray.shape[0], -1))

cat_gray = to_gray(cat_image)
cat_flat = cat_gray.flatten()

scaler = StandardScaler()
horse_flat_scaled = scaler.fit_transform(horse_flat)
cat_flat_scaled = scaler.transform(cat_flat.reshape(1, -1))[0]

sparsity_levels = [1, 5, 10, 20, 50, 100, 200, 500]
errors = []
nz_counts = []
reconstructions = []

for s in sparsity_levels:
    D = horse_flat_scaled[:s].T
    lasso = Lasso(alpha=0.01, max_iter=10000, fit_intercept=False)
    lasso.fit(D, cat_flat_scaled)
    recon = D @ lasso.coef_
    error = np.linalg.norm(cat_flat_scaled - recon)
    errors.append(error)
    nz_counts.append(np.sum(lasso.coef_ != 0))
    
    # Store reconstruction for visualization
    recon_unscaled = scaler.inverse_transform(recon.reshape(1, -1))[0]
    recon_img = recon_unscaled.reshape(32, 32)
    reconstructions.append(recon_img)

# Create subplot layout
fig, axes = plt.subplots(2, 5, figsize=(20, 8))

# Show original cat image
axes[0, 0].imshow(cat_gray, cmap='gray')
axes[0, 0].set_title('Original Cat')
axes[0, 0].axis('off')

# Show error plot
axes[0, 1].plot(sparsity_levels, errors, marker='o')
axes[0, 1].set_xlabel('Number of Horse Images Used')
axes[0, 1].set_ylabel('Reconstruction Error (L2 Norm)')
axes[0, 1].set_title('Reconstruction Error')
axes[0, 1].grid(True)

# Show reconstructions
for i, (s, recon_img) in enumerate(zip(sparsity_levels, reconstructions)):
    if i < 3:  # First 3 in top row
        row, col = 0, i + 2
    else:  # Remaining 5 in bottom row
        row, col = 1, i - 3
    axes[row, col].imshow(recon_img, cmap='gray')
    axes[row, col].set_title(f'{s} horses')
    axes[row, col].axis('off')

plt.tight_layout()
plt.show()

for s, err, nz in zip(sparsity_levels, errors, nz_counts):
    print(f"Used {s} horse images → error = {err:.2f}, nonzeros = {nz}")

