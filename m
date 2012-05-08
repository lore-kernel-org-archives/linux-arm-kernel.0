From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 May 2012 22:40:51 +0800
Subject: [PATCH 07/10] mmc: mxs-mmc: copy wp_gpio in struct mxs_mmc_host
In-Reply-To: <201205080153.44313.marex@denx.de>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
 <1336401793-13753-8-git-send-email-shawn.guo@linaro.org>
 <201205080153.44313.marex@denx.de>
Message-ID: <20120508144047.GG2199@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 01:53:44AM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > It has wp_gpio copied in struct mxs_mmc_host from platform_data,
> 
> Copy wp_gpio into struct ...
> 
Updated.

> > so that the use of platform_data can be limited in probe function,
> > which will ease the device tree probe.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Otherwise
> Acked-by: Marek Vasut <marex@denx.de>
> 
Thanks.

-- 
Regards,
Shawn
