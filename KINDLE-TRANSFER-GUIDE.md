# How to Transfer Encyclopedia to Your Kindle

Your **Reliability and Asset Management Encyclopedia** has been converted to ebook format!

📚 **Ebook Location:** `ebook-output/Reliability-Asset-Management-Encyclopedia.epub`
📊 **File Size:** 373 KB
📖 **Format:** EPUB (compatible with Kindle devices and apps since 2022)

---

## Transfer Methods

### Method 1: Email to Kindle (Easiest) ⭐ RECOMMENDED

1. **Find your Kindle email address:**
   - Go to [Amazon Content & Devices](https://www.amazon.com/hz/mycd/digital-console/contentlist/booksAll/dateDsc/)
   - Click **Preferences** → **Personal Document Settings**
   - Look for "Send-to-Kindle Email Settings" (e.g., `yourname@kindle.com`)

2. **Add your email to approved list:**
   - In the same "Personal Document Settings" page
   - Scroll to "Approved Personal Document E-mail List"
   - Add the email address you'll send from

3. **Email the ebook:**
   - Attach: `Reliability-Asset-Management-Encyclopedia.epub`
   - To: `your-kindle-email@kindle.com`
   - Subject: (optional, can be anything)
   - Body: (optional, can be empty)
   - Send!

4. **Wait 5-10 minutes** - The book will appear on your Kindle automatically

**Notes:**
- File limit: 50 MB (this file is only 373 KB ✓)
- EPUB is supported on Kindle devices from 2022+ and all Kindle apps
- The book will sync across all your Kindle devices

---

### Method 2: USB Cable Transfer

**For Kindle E-readers:**

1. Connect your Kindle to computer via USB cable
2. Your Kindle will appear as a USB drive
3. Open the Kindle drive
4. Copy `Reliability-Asset-Management-Encyclopedia.epub` to the **Documents** folder
5. Safely eject the Kindle
6. The book will appear in your library

**Note:** USB transferred books won't sync across devices

---

### Method 3: Send to Kindle App (Desktop)

1. Download **Amazon Send to Kindle** app:
   - Windows: https://www.amazon.com/sendtokindle
   - Mac: https://www.amazon.com/sendtokindle

2. Install and sign in with your Amazon account

3. Right-click the EPUB file → **Send to Kindle**

4. Select which devices to send to

5. Click **Send**

---

### Method 4: Kindle App on Mobile (iOS/Android)

**For Kindle App Users:**

1. Email the EPUB file to yourself
2. Open email on your phone/tablet
3. Tap the EPUB file attachment
4. Select **Open in Kindle** or **Share → Kindle**
5. The book will be added to your library

---

## Verification

After transferring, verify the book appears:

- **Kindle Device:** Home → My Library → All
- **Kindle App:** Library → Downloaded (after sync)
- **Cloud Library:** Should appear within 5-10 minutes for email method

---

## Troubleshooting

### Book doesn't appear after emailing:
- ✓ Verify sender email is on approved list
- ✓ Check you used the correct Kindle email address
- ✓ Wait 10-15 minutes for processing
- ✓ Check your regular email for error messages from Amazon
- ✓ Ensure file size is under 50 MB (this file is 373 KB)

### EPUB not supported error:
- If you have an older Kindle (pre-2022), you need MOBI format
- Run: `./convert-to-mobi.sh` (I can create this script if needed)
- Or use Calibre to convert EPUB → AZW3

### Book appears but won't open:
- Try re-sending/re-transferring
- Ensure your Kindle software is up to date
- Try a different transfer method

---

## File Formats Explained

**EPUB** (What we created)
- ✓ Modern standard format
- ✓ Supported by Kindle (2022+)
- ✓ Best formatting and features
- ✓ Smaller file size

**MOBI/AZW3** (Older Kindle format)
- ⚠ Legacy format
- ⚠ Deprecated by Amazon
- ✓ Works on older Kindles (pre-2022)
- Can convert if needed

---

## Reading Tips

This encyclopedia is **250,000+ words** across 16 documents:

- **Use the Table of Contents:** Tap the top of the screen → Table of Contents
- **Navigate by chapter:** Use the navigation controls
- **Bookmark sections:** Long-press to bookmark important sections
- **Search:** Use the search function to find specific topics
- **Adjust text size:** Make it comfortable for extended reading

---

## Additional Options

### Want to create a MOBI version for older Kindles?

I can create a conversion script using:
- Calibre's `ebook-convert` tool, or
- Pandoc with MOBI output

Just let me know if you need this!

### Want to split into multiple smaller books?

The encyclopedia could be split into topic-specific volumes:
- Volume 1: Core Technologies & RCM
- Volume 2: Condition Monitoring Technologies
- Volume 3: Digital Infrastructure
- Volume 4: Industry Standards & Resources

---

## Quick Start Command

To rebuild the ebook after making changes to the markdown files:

```bash
./build-ebook.sh
```

Output will be in: `ebook-output/Reliability-Asset-Management-Encyclopedia.epub`

---

## Support

**Kindle Support Resources:**
- [Send to Kindle Help](https://www.amazon.com/gp/sendtokindle/email)
- [Kindle Personal Documents](https://www.amazon.com/gp/help/customer/display.html?nodeId=G5WYD9SAF7PGXRNA)
- [Supported Formats](https://www.amazon.com/gp/help/customer/display.html?nodeId=GX5VE3C4Y8VCKN)

---

**Happy Reading! 📚**

*Last Updated: November 19, 2025*
