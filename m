From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Feb 2014 15:36:52 -0800
Subject: [PATCH v2 0/4] ARM: dts: Fixes for Overo/Tobi against 3.14-rc2
In-Reply-To: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20140213233652.GU28216@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [140213 02:28]:
> OMAP36xx-based Overo (Storm and alike) are now failing to boot with 3.14-rc2 [1].
> This series fixes this, by moving model-agnostic DT into a common dtsi file,
> and creating model-specific DT files:
> 
> - omap3-overo-tobi.dts -> older OMAP35xx Overo
> - omap3-overo-storm-tobi.dts -> newer OMAP36xx/AM37xx/DM37xx Overo
> 
> People will have to use the right Overo / expansion board combination.
> 
> (Patch 2 in an unrelated fix that was waiting in my queue.)
> 
> omap3-overo-tobi.dts tested with Overo Sand (OMAP3503) and omap3-overo-storm-tobi.dts
> tested with Overo EarthStorm (AM3703). Both boot. With the Overo Sand, I cannot
> mount the ext3 rootfs, but this seems unrelated to the current topic, maybe
> a missing errata.

Applying patches 1 to 3 into omap-for-v3.14/fixes thanks, the last
one still seems to have discussion going.

Tony
