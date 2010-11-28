From: cjb@laptop.org (Chris Ball)
Date: Sun, 28 Nov 2010 02:39:24 +0000
Subject: [PATCH] omap: zoom: wl1271 slot is MMC_CAP_POWER_OFF_CARD
In-Reply-To: <1290815964-30088-1-git-send-email-ohad@wizery.com>
References: <1290815964-30088-1-git-send-email-ohad@wizery.com>
Message-ID: <20101128023924.GA6019@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Nov 27, 2010 at 01:59:24AM +0200, Ohad Ben-Cohen wrote:
> This patch complements ed919b0 "mmc: sdio: fix runtime PM anomalies by
> introducing MMC_CAP_POWER_OFF_CARD" by declaring MMC_CAP_POWER_OFF_CARD
> on the ZOOM's wl1271 mmc slot.
> 
> This is required in order not to break runtime PM support for the wl1271
> sdio driver.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Looks good.  Tony, feel free to take this for .37 through your tree.

Signed-off-by: Chris Ball <cjb@laptop.org>

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
