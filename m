From: khilman@ti.com (Kevin Hilman)
Date: Tue, 13 Dec 2011 15:46:47 -0800
Subject: [PATCH 2/6] OMAP2+: omap_hwmod: manage the wake-up latency
 constraints
In-Reply-To: <1323706701-6627-3-git-send-email-j-pihet@ti.com> (jean pihet's
 message of "Mon, 12 Dec 2011 17:18:17 +0100")
References: <1323706701-6627-1-git-send-email-j-pihet@ti.com>
 <1323706701-6627-3-git-send-email-j-pihet@ti.com>
Message-ID: <87hb14t4pk.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jean.pihet at newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Hwmod is queried from the OMAP_PM layer to manage the power domains

nit: changelog needs a refresh as this isn't called from OMAP PM layer.

> wake-up latency constraints. Hwmod retrieves the correct power domain
> and if it exists it calls the corresponding power domain function.
>
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
> latency constraints on MPU, CORE and PER.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Kevin
