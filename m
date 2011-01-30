From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 30 Jan 2011 19:59:34 +0000
Subject: [PATCH] ARM: print FPGA info on plat-versatile variants
In-Reply-To: <1296128890-18765-1-git-send-email-linus.walleij@stericsson.com>
References: <1296128890-18765-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110130195934.GC27436@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 12:48:10PM +0100, Linus Walleij wrote:
> This adds a small piece of code that displays some basic FPGA
> characteristics for the Integrator, Versatile, RealView and
> Versatile Express reference platforms. Tested on RealView
> variants.

I think it needs a few tweaks for Versatile Express:

arch/arm/plat-versatile/fpga-id.c:14:27: error: mach/platform.h: No such file or directory
arch/arm/plat-versatile/fpga-id.c: In function ?versatile_fpga_probe?:
arch/arm/plat-versatile/fpga-id.c:78: error: implicit declaration of function ?MMIO_P2V?
arch/arm/plat-versatile/fpga-id.c:78: error: ?V2M_SYS_ID? undeclared (first use in this function)
arch/arm/plat-versatile/fpga-id.c:78: error: (Each undeclared identifier is reported only once
arch/arm/plat-versatile/fpga-id.c:78: error: for each function it appears in.)
arch/arm/plat-versatile/fpga-id.c:78: warning: assignment makes pointer from integer without a cast
arch/arm/plat-versatile/fpga-id.c: At top level:
arch/arm/plat-versatile/fpga-id.c:173: warning: initialization from incompatible pointer type
