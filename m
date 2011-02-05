From: nickpelling@nanodome.com (Nick Pelling)
Date: Sat, 05 Feb 2011 09:59:35 +0000
Subject: "Porting the Linux Kernel to a New ARM Platform",
  updated...?
In-Reply-To: <AANLkTikWsU2V+1ohAaiFfRneLjsGRWx7ee5X655mAa18@mail.gmail.c
 om>
References: <1295968115-11447-1-git-send-email-fabio.estevam@freescale.com>
	<20110127073009.GR9041@pengutronix.de>
	<20110127093044.GA30756@shlinux1.ap.freescale.net>
	<4D415BA2.2020207@freescale.com>
	<20110127121928.GA1948@richard-laptop>
	<87a7d0$e7q8m3@out1.ip07ir2.opaltelecom.net>
	<AANLkTikWsU2V+1ohAaiFfRneLjsGRWx7ee5X655mAa18@mail.gmail.com>
Message-ID: <9fl3fn$dtqe5n@out1.ip09ir2.opaltelecom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

At 08:31 03/02/2011 -0600, Steve Chen wrote:
>I took a quick look at the document.  Much of the information still
>applies to the latest kernel.  The biggest change that I can see is
>that the directories were moved and files renames.  For example
>
>arch/arm/deconfigs/ is now arch/arm/configs
>config.in is now Kconfig
>include/asm-arm/arch-xxx is moved to arch/arm/mach-xxx/include
>
>By the way, include/asm is a symlink points to
>include/asm-arm/arch-xxxx in the older kernels.  The link is created
>by the make.  If I were to get Linux to boot on a new board, I would
>start by looking at code for a similar target with the same SoC.

Thanks, Steve, very helpful. I also got an off-list message from 
Wookey, who said of his document that...

"more recent docs have been written superseding much of what is in 
there (e.g Vince Sanders' booting the kernel doc: 
http://www.simtec.co.uk/products/SWLINUX/files/booting_article.html#
but which is about to be finally outdated by devicetree possibilities)"

He also suggested http://free-electrons.com/doc/kernel-porting.pdf as 
likely to be useful.

Cheers, ....Nick Pelling.... 
