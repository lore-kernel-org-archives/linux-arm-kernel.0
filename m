From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 May 2012 22:35:32 +0800
Subject: [PATCH 03/10] mmc: mxs-mmc: get rid of the use of cpu_is_xxx
In-Reply-To: <201205080146.45090.marex@denx.de>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
 <1336401793-13753-4-git-send-email-shawn.guo@linaro.org>
 <201205080146.45090.marex@denx.de>
Message-ID: <20120508143529.GE2199@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 01:46:44AM +0200, Marek Vasut wrote:
> > -#define SSP_VERSION_LATEST	4
> > -#define ssp_is_old(host)	(host->version < SSP_VERSION_LATEST)
> > +#define ssp_is_old(host)	(host->devid == IMX23_MMC)
> 
> (host)->devid ...
> 
Fixed, as well as dma_is_apbh and apbh_is_old.  Thanks.

-- 
Regards,
Shawn
