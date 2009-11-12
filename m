From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 12 Nov 2009 12:47:07 +0000
Subject: [PATCH 8/9] MXC: Add a digital audio multiplexer (DAM) driver
In-Reply-To: <1258022525-21078-9-git-send-email-s.hauer@pengutronix.de>
References: <1258022525-21078-9-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20091112124706.GB11656@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 11:42:04AM +0100, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx2/Kconfig            |    2 +
>  arch/arm/mach-mx3/Kconfig            |    2 +
>  arch/arm/plat-mxc/Kconfig            |    7 ++++
>  arch/arm/plat-mxc/Makefile           |    2 +
>  arch/arm/plat-mxc/dam-v1.c           |   33 ++++++++++++++++++++
>  arch/arm/plat-mxc/dam-v2.c           |   56 ++++++++++++++++++++++++++++++++++

Is there any great reason to use the DAM name rather than AUDMUX?  I've
never heard it called anything except AUDMUX before, though I may have
been missing something.
