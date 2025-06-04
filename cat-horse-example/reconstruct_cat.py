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

sparsity_levels = [1, 5, 10, 20, 50, 100, 200]
errors = []
nz_counts = []

for s in sparsity_levels:
    D = horse_flat_scaled[:s].T
    lasso = Lasso(alpha=0.01, max_iter=10000, fit_intercept=False)
    lasso.fit(D, cat_flat_scaled)
    recon = D @ lasso.coef_
    error = np.linalg.norm(cat_flat_scaled - recon)
    errors.append(error)
    nz_counts.append(np.sum(lasso.coef_ != 0))

plt.figure(figsize=(8, 5))
plt.plot(sparsity_levels, errors, marker='o')
plt.xlabel('Number of Horse Images Used')
plt.ylabel('Reconstruction Error (L2 Norm)')
plt.title('Cat Approximation using Sparse Horse Dictionary')
plt.grid(True)
plt.tight_layout()
plt.show()

for s, err, nz in zip(sparsity_levels, errors, nz_counts):
    print(f"Used {s} horse images → error = {err:.2f}, nonzeros = {nz}")

