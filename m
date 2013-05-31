From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 01 Jun 2013 09:40:30 +1000
Subject: [PATCH v2] can: flexcan: remove HAVE_CAN_FLEXCAN Kconfig symbol
In-Reply-To: <519A4A00.8000109@pengutronix.de>
References: <1368781157-4646-1-git-send-email-mkl@pengutronix.de>
 <20130517090949.GI8607@S2101-09.ap.freescale.net>
 <519A4A00.8000109@pengutronix.de>
Message-ID: <1370043630.3928.166.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-05-20 at 18:06 +0200, Marc Kleine-Budde wrote:
> On 05/17/2013 11:09 AM, Shawn Guo wrote:
> > On Fri, May 17, 2013 at 10:59:17AM +0200, Marc Kleine-Budde wrote:
> >> This patch removes the Kconfig symbol HAVE_CAN_FLEXCAN from arch/{arm,powerpc}
> >> and allowing compilation unconditionally on all arm and powerpc platforms.
> >>
> >> This brings a bigger compile time coverage and removes the following dependency
> >> warning found by Arnd Bergmann:
> >>
> >>     warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 && IMX_HAVE_PLATFORM_FLEXCAN &&
> >>         SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_FLEXCAN
> >>     which has unmet direct dependencies (NET && CAN && CAN_DEV)
> >>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Shawn Guo <shawn.guo@linaro.org>
> > 
> > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Thanks.
> 
> An Acked-by by the powerpc people would be fine. However, if nobody
> doesn't object, I'm sending this patch via linux-can and net-next upstream.

Sorry, missed it, if it's still out there, add my

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.
