From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 04:34:40 -0700
Subject: [PATCH v5 1/7] ARM: dts: omap3: Add clocks to McBSP nodes
In-Reply-To: <20160530082350.24285-2-peter.ujfalusi@ti.com>
References: <20160530082350.24285-1-peter.ujfalusi@ti.com>
 <20160530082350.24285-2-peter.ujfalusi@ti.com>
Message-ID: <20160610113440.GD22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160530 01:26]:
> Add clock properties to the McBSP nodes. McBSP2 and 3 need to have ick also
> since the Sidetone block of these modules are operating using the McBSP
> interface clock.

Applying this patch into omap-for-v4.8/dt thanks.

Tony
