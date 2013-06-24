From: axel.lin@ingics.com (Axel Lin)
Date: Mon, 24 Jun 2013 21:14:08 +0800
Subject: [Linux 3.10-rc7] at91x40_defconfig build error
Message-ID: <1372079648.24001.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I got below build error by "make at91x40_defconfig; make".

  LD      init/built-in.o
fs/built-in.o: In function `copy_strings':
super.c:(.text+0x634c): undefined reference to `flush_kernel_dcache_page'
super.c:(.text+0x63d4): undefined reference to `flush_kernel_dcache_page'
lib/built-in.o: In function `sg_miter_stop':
strnlen_user.c:(.text+0x3394): undefined reference to `flush_kernel_dcache_page'
make: *** [vmlinux] Error 1

Any idea to fix this?

Thanks,
Axel
