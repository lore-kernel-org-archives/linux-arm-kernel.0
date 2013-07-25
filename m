From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Jul 2013 09:37:19 -0700
Subject: [PATCH v1 05/14] clk: msm: Add support for phase locked loops
 (PLLs)
In-Reply-To: <6003715.TMZ71jDUbL@flatron>
References: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
 <1374713022-6049-6-git-send-email-sboyd@codeaurora.org>
 <6003715.TMZ71jDUbL@flatron>
Message-ID: <20130725163719.GD29694@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25, Tomasz Figa wrote:
> On Wednesday 24 of July 2013 17:43:33 Stephen Boyd wrote:
> > +extern struct clk *pll_clk_register(struct device *dev, struct pll_desc
> > *desc, +		struct clk_init_data *init);
> > +extern struct clk *pll_vote_clk_register(struct device *dev,
> > +		struct pll_vote_desc *desc, struct clk_init_data *init);
> 
> I don't think such generic name is good here. What about prefixing them 
> with msm_ or qcom_ string?
> 

Sure.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
