From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Sep 2010 10:45:12 -0700
Subject: [PATCH v6 7/7] omap: zoom: add mmc3/wl1271 device support
In-Reply-To: <1284593551-30141-1-git-send-email-ohad@wizery.com>
References: <1284593551-30141-1-git-send-email-ohad@wizery.com>
Message-ID: <20100916174512.GD29610@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [100915 16:23]:
> Add MMC3 support on ZOOM, which has the wl1271 device hardwired to.
> 
> The wl1271 is a 4-wire, 1.8V, embedded SDIO WLAN device with an
> external IRQ line, and power-controlled by a GPIO-based fixed regulator.

Acked-by: Tony Lindgren <tony@atomide.com>
