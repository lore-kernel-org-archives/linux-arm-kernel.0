From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 May 2013 10:03:52 +0800
Subject: [PATCH] can: flexcan: allow compilation on arm and powerpc
In-Reply-To: <1368711756-22324-1-git-send-email-mkl@pengutronix.de>
References: <1368711756-22324-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20130517020351.GE3893@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Thu, May 16, 2013 at 03:42:36PM +0200, Marc Kleine-Budde wrote:
> This patch removes the Kconfig symbols HAVE_CAN_FLEXCAN and
> IMX_HAVE_PLATFORM_FLEXCAN from arch/{arm,powerpc} and allowing compilation on
> all arm and powerpc platforms.

I'm generally fine with the approach.  But with Kconfig symbol
IMX_HAVE_PLATFORM_FLEXCAN removed, how does the build of
platform-flexcan.o work?

arch/arm/mach-imx/devices/Makefile:obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o

Shawn
