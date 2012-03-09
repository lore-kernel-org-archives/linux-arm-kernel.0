From: tony@atomide.com (Tony Lindgren)
Date: Fri, 9 Mar 2012 10:33:44 -0800
Subject: [PATCH 1/2] ARM: OMAP: Remove CONFIG_OMAP_MCBSP references
In-Reply-To: <1331283078-14846-2-git-send-email-peter.ujfalusi@ti.com>
References: <1331283078-14846-1-git-send-email-peter.ujfalusi@ti.com>
 <1331283078-14846-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120309183344.GI12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120309 00:54]:
> The McBSP driver stack has been moved to ASoC. The CONFIG_OMAP_MCBSP will
> be removed since the CONFIG_SND_OMAP_SOC_MCBSP will trigger to build the
> McBSP (audio) drivers.

Great, glad to see this! Thanks for working on this:

Acked-by: Tony Lindgren <tony@atomide.com>
