#!/bin/bash

# Build ebook from markdown encyclopedia
# This script combines all markdown files in the proper order

echo "Building Reliability and Asset Management Encyclopedia ebook..."

# Create output directory if it doesn't exist
mkdir -p ebook-output

# List of files in the proper reading order
FILES=(
    "README.md"
    "major-contributors-encyclopedia.md"
    "reliability-centered-maintenance.md"
    "History_of_Reliability_and_Asset_Management.md"
    "Static_Equipment_Condition_Monitoring.md"
    "electrical-condition-monitoring.md"
    "Instrumentation_Condition_Monitoring.md"
    "docs/industrial-communication-protocols.md"
    "docs/protocol-comparison-reference.md"
    "docs/protocol-implementation-examples.md"
    "network-architecture-industrial-iot.md"
    "predictive-maintenance-algorithms-encyclopedia.md"
    "industry-specific-advances.md"
    "reliability-standards-reference.md"
    "Notable_Podcasts_and_Educational_Resources.md"
)

# Build the pandoc command with all files
pandoc metadata.yaml "${FILES[@]}" \
    -o "ebook-output/Reliability-Asset-Management-Encyclopedia.epub" \
    --toc \
    --toc-depth=3 \
    --epub-chapter-level=1 \
    --metadata-file=metadata.yaml \
    --standalone

if [ $? -eq 0 ]; then
    echo "✓ EPUB created successfully!"
    ls -lh ebook-output/Reliability-Asset-Management-Encyclopedia.epub
else
    echo "✗ Error creating EPUB"
    exit 1
fi

echo ""
echo "Ebook created at: ebook-output/Reliability-Asset-Management-Encyclopedia.epub"
echo "File size: $(du -h ebook-output/Reliability-Asset-Management-Encyclopedia.epub | cut -f1)"
