From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Feb 2012 09:21:59 -0800
Subject: [RFC 02/11] OMAP: mcbsp: Move core driver under sound/soc/omap
In-Reply-To: <1329320280-1621-3-git-send-email-peter.ujfalusi@ti.com>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
 <1329320280-1621-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120220172159.GK18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120215 07:07]:
> In order to consolidate the McBSP driver move it out from
> arch/arm/plat-omap directory under sound/soc/omap/
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks for doing this! These may cause some minor merge
conflicts with the planned header clean-up, but those should
be trivial to deal with.

Acked-by: Tony Lindgren <tony@atomide.com>
