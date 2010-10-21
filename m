From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 Oct 2010 20:44:18 +0200
Subject: [PATCH 0/2] mx25_3ds & mx35_3ds: add mmc support
In-Reply-To: <1287678225-11066-1-git-send-email-shawn.gsc@gmail.com>
References: <1287678225-11066-1-git-send-email-shawn.gsc@gmail.com>
Message-ID: <20101021184418.GW19834@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Oct 22, 2010 at 12:23:43AM +0800, Shawn Guo wrote:
> The patch was tested on top of Uwe's build fix below. 
> 
>  ARM: mx3: fix build failure concerning MXC_INT_MMC_SDHC2
> 
> Shawn Guo (3)
>  [PATCH 1/2] mx35_3ds: add mmc support
>  [PATCH 2/2] mx25_3ds: add mmc support
Both look ok, Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
>  arch/arm/mach-mx25/Kconfig         |    1 +
>  arch/arm/mach-mx25/mach-mx25_3ds.c |   10 ++++++++++
>  arch/arm/mach-mx3/Kconfig          |    1 +
>  arch/arm/mach-mx3/mach-mx35_3ds.c  |    8 ++++++++
>  4 files changed, 20 insertions(+), 0 deletions(-)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
