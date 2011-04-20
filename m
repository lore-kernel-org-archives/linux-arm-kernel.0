From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 20 Apr 2011 19:16:24 +0800
Subject: [PATCH 0/3] fix some issues with the kernel decompressor
In-Reply-To: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110420111623.GD1965@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 12:15:01AM -0400, Nicolas Pitre wrote:
> Here some patches to fix some issues with the zImage code.  The LZMA
> decompressor now works for me, and the DT append patch should work
> on all platforms now too.
> 
> [PATCH 1/3] ARM: zImage: no need to get the decompressed size from the filesystem
> [PATCH 2/3] ARM: compressed/misc.c: simplify decompress_kernel()
> [PATCH 3/3] ARM: zImage: fix issues with missing GOT entries for some global variables
> 
Tested-by: Shawn Guo <shawn.guo@linaro.org>

On mx51 babbage, tested both LZMA decompressor and DTB append patch.

-- 
Regards,
Shawn
