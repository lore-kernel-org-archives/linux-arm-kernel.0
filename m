From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jul 2015 10:36:43 -0700
Subject: [PATCH v5 01/10] clk: mediatek: Removed unused dpi_ck clock from
 MT8173
In-Reply-To: <1438154233.17770.39.camel@mtksdaap41>
References: <1438152754-11970-1-git-send-email-jamesjj.liao@mediatek.com>
 <1438152754-11970-2-git-send-email-jamesjj.liao@mediatek.com>
 <6282882.pftQBj38E3@diego> <1438154233.17770.39.camel@mtksdaap41>
Message-ID: <20150730173643.GH3159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29, James Liao wrote:
> Hi Stephen,
> 
> Could you help to apply this patch into 4.2?
> 
> 
> Best regards,
> 
> James
> 
> On Wed, 2015-07-29 at 09:05 +0200, Heiko St?bner wrote:
> > Am Mittwoch, 29. Juli 2015, 14:52:25 schrieb James Liao:
> > > The dpi_ck clock can be removed because it not actually used
> > > in topckgen and subsystems.
> > > 
> > > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > 
> > From our past discussions this change looks about right, and should still 
> > become _part of 4.2_, to not have the CLK_TOP_DPI become part of the 
> > devicetree CLK_TOP_DPI.

Did you mean ABI?

> > 
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > 

Is it being used in DT right now and causing regressions on
v4.2-rcX? Sorry, I'm trying to understand why this patch matters
for the 4.2 release.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
