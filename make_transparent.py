#!/usr/bin/env python3
from PIL import Image

def make_transparent(input_path, output_path, threshold=240):
    """
    Convert white background to transparent in an image.
    
    Args:
        input_path: Path to the input image
        output_path: Path where to save the resulting image
        threshold: RGB threshold to determine which pixels to make transparent (0-255)
    """
    # Open the image
    img = Image.open(input_path)
    
    # Convert to RGBA if it's not already
    if img.mode != 'RGBA':
        img = img.convert('RGBA')
    
    # Get the data
    data = img.getdata()
    
    # Create a new list for the modified data
    new_data = []
    
    # Process each pixel
    for item in data:
        # If pixel is mostly white (all values > threshold), make it transparent
        if item[0] > threshold and item[1] > threshold and item[2] > threshold:
            new_data.append((255, 255, 255, 0))  # Transparent
        else:
            new_data.append(item)  # Keep as is
    
    # Update image with new data
    img.putdata(new_data)
    
    # Save the result
    img.save(output_path)
    print(f"Image processed and saved to {output_path}")

if __name__ == "__main__":
    # Process all three creatura files
    for i in range(1, 4):
        input_file = f"www/creatura_{i}.png"
        output_file = f"www/creatura_{i}_transparent.png"
        print(f"Processing {input_file}...")
        make_transparent(input_file, output_file)
