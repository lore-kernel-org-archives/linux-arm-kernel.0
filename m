From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Jan 2011 17:04:04 -0800
Subject: [PATCH v6.1 3/3] omap3: beaglexm: fix power on of DVI
In-Reply-To: <1294791809-28069-1-git-send-email-nm@ti.com>
References: <1294791809-28069-1-git-send-email-nm@ti.com>
Message-ID: <20110112010403.GB4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [110111 16:22]:
> From: Koen Kooi <koen@beagleboard.org>
> 
> TFP410 DVI chip is used to provide display out.
> This chip is controlled by 2 lines:
> LDO which supplies the power is controlled over gpio + 2
> and the enable of the chip itself is done over gpio + 1
> NOTE: the LDO is necessary for LED, serial blocks as well.
> 
> gpio + 1 was used to sense USB overcurrent in vanilla beagle.
> 
> Without this fix, the display would not function as the LDO
> remains shut down.

Thanks, applying.

Tony
