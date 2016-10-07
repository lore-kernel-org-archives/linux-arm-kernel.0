From: joe@perches.com (Joe Perches)
Date: Fri, 07 Oct 2016 13:44:46 -0700
Subject: [PATCH 4/10] MAINTAINERS: add entry for Marvell Xenon MMC Host
 Controller drivers
In-Reply-To: <86b237c01d9767d4e0edf6d41194ab959838e5c0.1475853198.git-series.gregory.clement@free-electrons.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
 <86b237c01d9767d4e0edf6d41194ab959838e5c0.1475853198.git-series.gregory.clement@free-electrons.com>
Message-ID: <1475873086.1945.20.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-10-07 at 17:22 +0200, Gregory CLEMENT wrote:
> Add maintainer entry for Marvell Xenon eMMC/SD/SDIO Host
> Controller drivers.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -7578,6 +7578,11 @@ M:	Nicolas Pitre <nico@fluxnic.net>
>  S:	Odd Fixes
>  F:	drivers/mmc/host/mvsdio.*
>  
> +MARVELL XENON MMC/SD/SDIO HOST CONTROLLER DRIVER
> +M:	Ziji Hu <huziji@marvell.com>
> +L:	linux-mmc at vger.kernel.org
> +S:	Supported

You should really add F: file patterns here
