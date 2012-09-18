From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 18 Sep 2012 09:40:18 +0800
Subject: [PATCH 25/34] dma: imx-dma: remove mach/hardware.h inclusion
In-Reply-To: <20120917075814.GO6180@pengutronix.de>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-26-git-send-email-shawn.guo@linaro.org>
 <20120917075814.GO6180@pengutronix.de>
Message-ID: <20120918014016.GF1338@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 09:58:14AM +0200, Sascha Hauer wrote:
> I know the important thing for you is to get rid of the mach/hardware.h
> inclusion, but I think the subject for this patch should rather be that
> you switch to platform_device_id for this driver.
> 
Ok, I will update the subject for the patch and the similar ones.

> This patch misses to adjust the clock lookups according to the new
> platform_device_ids. Please fixup the patch with the following.
> 
Ok, will do.  Thanks, Sascha.

Regards,
Shawn
