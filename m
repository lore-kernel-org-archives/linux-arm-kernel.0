From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 14 May 2010 10:41:49 +0200
Subject: [PATCH 17/20] pxa3xx_nand: add cmdline part parser support
In-Reply-To: <1273824971.9999.1582.camel@macbook.infradead.org>
References: <h2l771cded01005060212k39b41e4aqa57cc6e5072bfe3b@mail.gmail.com>
	<1273804364.9999.881.camel@macbook.infradead.org>
	<AANLkTikMrVigamYF8VAiEB3_JXGr6LAFliOmw9CJr8mz@mail.gmail.com>
	<1273824971.9999.1582.camel@macbook.infradead.org>
Message-ID: <20100514084149.GJ30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 09:16:11AM +0100, David Woodhouse wrote:
> On Fri, 2010-05-14 at 14:08 +0800, Haojian Zhuang wrote:
> > New patches are rebased for mtd-2.6 master branch. There're contained
> > in another mail loop.
> 
> Hm, please test these by sending to yourself first, saving the patches
> and checking that they apply.
> 
> [dwmw2 at macbook mtd-2.6]$ git describe HEAD
> v2.6.34-rc7-142-gf6b173c
> 
> [dwmw2 at macbook mtd-2.6]$ for a in `seq -w 1 20` ; do echo Patch $a ; patch -p1 < pxa$a.patch ; done
> Patch 01
> patching file arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
> patching file drivers/mtd/nand/Kconfig
> patching file drivers/mtd/nand/pxa3xx_nand.c
> patch: **** malformed patch at line 203: transfering to/from NAND HW");

Jep, they're line-wrapped, just like the version before.

Haojian, you can avoid this to happen by using 'git send-email'.

Thanks,
Daniel
