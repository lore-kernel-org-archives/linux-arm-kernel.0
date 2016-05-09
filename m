From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 May 2016 15:13:21 -0700
Subject: [PATCH v7 7/9] clk: mediatek: Enable critical clocks for MT2701
In-Reply-To: <1462772426.5344.7.camel@mtksdaap41>
References: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
 <1460621514-65191-8-git-send-email-jamesjj.liao@mediatek.com>
 <20160506231229.GJ3492@codeaurora.org>
 <1462772426.5344.7.camel@mtksdaap41>
Message-ID: <20160509221321.GT3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09, James Liao wrote:
> Hi Stephen,
> 
> On Fri, 2016-05-06 at 16:12 -0700, Stephen Boyd wrote:
> > On 04/14, James Liao wrote:
> > > Some system clocks should be turned on by default on MT2701.
> > > This patch enable these clocks when related clocks have
> > > been registered.
> > > 
> > > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > > ---
> > 
> > critical clks got merged now (sorry I'm slowly getting back to
> > looking at patches). Please use that flag.
> 
> I don't see critical clock support in v4.6-rc7. Is there a repo/branch
> that has critical clocks merged?
> 

Right, it's in clk-next in the clk tree.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
