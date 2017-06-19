From: tony@atomide.com (Tony Lindgren)
Date: Sun, 18 Jun 2017 23:02:57 -0700
Subject: [PATCH 12/16] mmc: host: omap_hsmmc: Add support to set IODELAY
 values
In-Reply-To: <20170616124544.15046-13-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
 <20170616124544.15046-13-kishon@ti.com>
Message-ID: <20170619060256.GK3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170616 05:47]:
> The data manual of J6/J6 Eco recommends to set different IODELAY values
> depending on the mode in which the MMC/SD is enumerated in order to
> ensure IO timings are met.
> 
> Add support to set the IODELAY values depending on the various MMC
> modes using the pinctrl APIs.

This does not seem to apply against Linux next for me for
the binding. Fixing that, compile fails for me with:

drivers/mmc/host/omap_hsmmc.c:2384:13: error:
'struct omap_hsmmc_platform_data' has no member named 'version'

So will wait for updates before giving this a try.

Regards,

Tony
