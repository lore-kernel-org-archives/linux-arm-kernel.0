From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 06:06:20 -0700
Subject: [PATCH v3 1/9] ARM/ASoC: omap-mcbsp: Move OMAP2+ clock
 parenting code to ASoC driver
In-Reply-To: <1345124468-8876-2-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120817130619.GY11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120816 06:41]:
> Move the McBSP CLKS re-parenting code to ASoC driver from
> arch/arm/mach-omap2.
> The call fort the re-parenting has been already limited to OMAP2+ SoC in
> the ASoC driver. There is no longer need to have callback function for it.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Acked-by: Tony Lindgren <tony@atomide.com>
