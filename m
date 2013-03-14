From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 14 Mar 2013 16:44:20 -0500
Subject: [PATCH 2/8] ARM: dts: OMAP36xx: move CPU OPP tables to device tree
In-Reply-To: <1363294695-658-3-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
 <1363294695-658-3-git-send-email-nm@ti.com>
Message-ID: <514244B4.9050808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/14/2013 03:58 PM, Nishanth Menon wrote:
> Add DT OPP table for OMAP36xx family of devices. This data is
> decoded by OF with of_init_opp_table() helper function. This
> overrides the default OMAP34xx CPU OPP table definition.

Not sure I following the last sentence. The tables are in a different
dtsi file and only the relevant file should be included, right?

Jon
