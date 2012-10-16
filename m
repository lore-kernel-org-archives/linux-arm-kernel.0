From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Oct 2012 10:51:43 -0700
Subject: [PATCH 5/5] arm/dts: am33xx: Add cpsw and mdio module nodes
 for AM33XX
In-Reply-To: <b4d88ef79fb0dec95bb598aaf1f15f0a7344c435.1350327325.git.richardcochran@gmail.com>
References: <cover.1350327320.git.richardcochran@gmail.com>
 <b4d88ef79fb0dec95bb598aaf1f15f0a7344c435.1350327325.git.richardcochran@gmail.com>
Message-ID: <20121016175143.GX15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Richard Cochran <richardcochran@gmail.com> [121015 12:23]:
> From: Mugunthan V N <mugunthanvnm@ti.com>
> 
> Add CPSW and MDIO related device tree data for AM33XX.
> Also enable them into board/evm dts files by providing
> respective phy-id.

These omap specific .dts changes  should be queued by Benoit Cousson,
please cc him and linux-omap.

Regards,

Tony
