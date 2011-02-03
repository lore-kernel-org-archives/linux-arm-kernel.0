From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Feb 2011 14:36:30 +0000
Subject: "Porting the Linux Kernel to a New ARM Platform", updated...?
In-Reply-To: <AANLkTikWsU2V+1ohAaiFfRneLjsGRWx7ee5X655mAa18@mail.gmail.com>
References: <1295968115-11447-1-git-send-email-fabio.estevam@freescale.com>
	<20110127073009.GR9041@pengutronix.de>
	<20110127093044.GA30756@shlinux1.ap.freescale.net>
	<4D415BA2.2020207@freescale.com>
	<20110127121928.GA1948@richard-laptop>
	<87a7d0$e7q8m3@out1.ip07ir2.opaltelecom.net>
	<AANLkTikWsU2V+1ohAaiFfRneLjsGRWx7ee5X655mAa18@mail.gmail.com>
Message-ID: <20110203143630.GC14627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 03, 2011 at 08:31:04AM -0600, Steve Chen wrote:
> By the way, include/asm is a symlink points to
> include/asm-arm/arch-xxxx in the older kernels.

In old kernels, include/asm was pointed at include/asm-arm.  We had a
second symlink for include/asm-arm/arch which pointed at
include/asm-arm/arch-xxx.  Even older kernels had another symlink for
include/asm-arm/proc pointing at either include/asm-arm/proc-armv or
.../proc-armo depending on whether we were building for 32-bit or 26-bit
ARMs.
