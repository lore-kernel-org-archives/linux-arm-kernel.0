From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 3 Jan 2013 13:52:53 -0600
Subject: [PATCH v4 19/19] irqchip: Move ARM vic.h to
 include/linux/irqchip/arm-vic.h
In-Reply-To: <1357235668-9450-20-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-20-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206D69AB480@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 03, 2013 10:54 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that we have VIC moved to drivers/irqchip and all VIC DT init for
> platforms using irqchip_init, move gic.h and update the remaining
> includes.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-samsung-soc at vger.kernel.org
> ---
>  arch/arm/mach-ep93xx/core.c                                         |    3 +--

For ep93xx:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
