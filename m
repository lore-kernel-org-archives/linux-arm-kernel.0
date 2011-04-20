From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 20 Apr 2011 00:15:01 -0400
Subject: [PATCH 0/3] fix some issues with the kernel decompressor
Message-ID: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here some patches to fix some issues with the zImage code.  The LZMA
decompressor now works for me, and the DT append patch should work
on all platforms now too.

[PATCH 1/3] ARM: zImage: no need to get the decompressed size from the filesystem
[PATCH 2/3] ARM: compressed/misc.c: simplify decompress_kernel()
[PATCH 3/3] ARM: zImage: fix issues with missing GOT entries for some global variables
