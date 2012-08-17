From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 06:09:04 -0700
Subject: [PATCH v3 8/9] ARM: OMAP2+: McBSP: Do not create legacy
 devices when booting with DT data
In-Reply-To: <1345124468-8876-9-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-9-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120817130904.GD11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120816 06:41]:
> Only create the devices in a legacy way if we do not have the DT data.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
