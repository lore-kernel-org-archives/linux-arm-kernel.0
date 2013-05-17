From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 May 2013 17:09:51 +0800
Subject: [PATCH v2] can: flexcan: remove HAVE_CAN_FLEXCAN Kconfig symbol
In-Reply-To: <1368781157-4646-1-git-send-email-mkl@pengutronix.de>
References: <1368781157-4646-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20130517090949.GI8607@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 10:59:17AM +0200, Marc Kleine-Budde wrote:
> This patch removes the Kconfig symbol HAVE_CAN_FLEXCAN from arch/{arm,powerpc}
> and allowing compilation unconditionally on all arm and powerpc platforms.
> 
> This brings a bigger compile time coverage and removes the following dependency
> warning found by Arnd Bergmann:
> 
>     warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 && IMX_HAVE_PLATFORM_FLEXCAN &&
>         SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_FLEXCAN
>     which has unmet direct dependencies (NET && CAN && CAN_DEV)
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: U Bhaskar-B22300 <B22300@freescale.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
