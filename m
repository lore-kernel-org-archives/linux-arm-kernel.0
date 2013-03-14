From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 14 Mar 2013 16:43:02 -0500
Subject: [PATCH 1/8] ARM: dts: OMAP34xx: move CPU OPP tables to device tree
In-Reply-To: <1363294695-658-2-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
 <1363294695-658-2-git-send-email-nm@ti.com>
Message-ID: <51424466.1060703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/14/2013 03:58 PM, Nishanth Menon wrote:
> Add DT OPP table for OMAP34xx family of devices. This data is
> decoded by OF with of_init_opp_table() helper function.
> 
> This is in preparation to use generic cpu0-cpufreq driver.

No mention here about what you are removing ;-)

Jon
