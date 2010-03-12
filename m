From: gianlucarenzi@eurekelettronica.it (gianluca)
Date: Fri, 12 Mar 2010 11:38:28 +0100
Subject: Query abut 2410 LCD configuration
In-Reply-To: <tencent_4B106ACE28F95B4E19D92218@qq.com>
References: <tencent_4B106ACE28F95B4E19D92218@qq.com>
Message-ID: <4B9A19A4.1080607@eurekelettronica.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?????? wrote:
> Im wondering these values DOES make any sense ?

Googling around you can find these settings for a board based on s3c2440
I think you can compare it with yours and noting the differences for 
you. What is the best configuration you get?

/* Configuration for 640x480 SHARP LQ080V3DG01 */
.lcdcon5 = S3C2410_LCDCON5_FRM565 |
S3C2410_LCDCON5_INVVLINE |
S3C2410_LCDCON5_INVVFRAME |
S3C2410_LCDCON5_PWREN |
S3C2410_LCDCON5_HWSWP,

.type        = S3C2410_LCDCON1_TFT,
.width        = 640,
.height        = 480,

.pixclock    = 166667, /* HCLK/4 */
.xres        = 640,
.yres        = 480,
.bpp        = 16,
.left_margin    = 48,
.right_margin    = 18,
.hsync_len    = 4,
.upper_margin    = 33,
.lower_margin    = 10,
.vsync_len    = 4,

Best luck!
-- 
            ,,,
           (o o)
======oOO==(_)==OOo======

Gianluca Renzi
R&D
phone: +39.0542.609120
fax:   +39.0542.609212

       .oooO  Oooo.
======(   )==(   )=======
        \ (    ) /
         \_)  (_/
