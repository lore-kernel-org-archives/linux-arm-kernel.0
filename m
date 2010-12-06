From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Dec 2010 15:50:41 -0800
Subject: [PATCH] omap: zoom: wl1271 slot is MMC_CAP_POWER_OFF_CARD
In-Reply-To: <20101128023924.GA6019@void.printf.net>
References: <1290815964-30088-1-git-send-email-ohad@wizery.com>
	<20101128023924.GA6019@void.printf.net>
Message-ID: <20101206235041.GT8345@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Chris Ball <cjb@laptop.org> [101127 18:29]:
> Hi,
> 
> On Sat, Nov 27, 2010 at 01:59:24AM +0200, Ohad Ben-Cohen wrote:
> > This patch complements ed919b0 "mmc: sdio: fix runtime PM anomalies by
> > introducing MMC_CAP_POWER_OFF_CARD" by declaring MMC_CAP_POWER_OFF_CARD
> > on the ZOOM's wl1271 mmc slot.
> > 
> > This is required in order not to break runtime PM support for the wl1271
> > sdio driver.
> > 
> > Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> 
> Looks good.  Tony, feel free to take this for .37 through your tree.
> 
> Signed-off-by: Chris Ball <cjb@laptop.org>

OK will merge thanks.

Tony
