From: minchan@kernel.org (Minchan Kim)
Date: Wed, 21 Oct 2015 17:59:20 +0900
Subject: [PATCH] fixup! mm: simplify reclaim path for MADV_FREE
In-Reply-To: <5799761.gmbM76C6JW@wuerfel>
References: <56273fe6.c8afc20a.628d8.ffff9ed8@mx.google.com>
 <5799761.gmbM76C6JW@wuerfel>
Message-ID: <20151021085920.GC23631@bbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Wed, Oct 21, 2015 at 10:47:16AM +0200, Arnd Bergmann wrote:
> On Wednesday 21 October 2015 00:33:58 kernelci. org bot wrote:
> > lpc18xx_defconfig (arm) ? FAIL, 55 errors, 18 warnings, 0 section mismatches
> > 
> > Errors:
> >     include/linux/rmap.h:274:1: error: expected declaration specifiers or '...' before '{' token
> >     include/linux/uaccess.h:88:13: error: storage class specified for parameter '__probe_kernel_read'
> >     include/linux/uaccess.h:99:53: error: storage class specified for parameter 'probe_kernel_write'
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e4f28388eb72 ("mm: simplify reclaim path for MADV_FREE")

Thanks for looking at this!
FYI, Andrew already sent a patch. https://lkml.org/lkml/2015/10/21/49
