From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 27 Jun 2013 21:11:19 +0800
Subject: [PATCH 0/3] ARM: imx: flexcan: convert transceiver switching to DT
In-Reply-To: <1372317731-24966-1-git-send-email-mkl@pengutronix.de>
References: <1372317731-24966-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20130627131117.GB2695@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 09:22:08AM +0200, Marc Kleine-Budde wrote:
> Hello,
> 
> this series converts the flexcan driver from using a callback function
> (configured via platform data), to switch the transceiver on and off, to a
> standard regulator. As there are no in-tree users of the platform data, it's
> finally removed.
> 
> If there are no objections I'd like to upstream this via can-next and David
> Miller's net-next. As these patches are touching arch/arm/mach-imx, I don't
> want to continue without some Acked-bys.
 
For the series,

Acked-by: Shawn Guo <shawn.guo@linaro.org>
