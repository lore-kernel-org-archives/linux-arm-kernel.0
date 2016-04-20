From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 20 Apr 2016 11:40:44 -0700
Subject: [PATCH v2 1/2] clk: Add Oxford Semiconductor OXNAS Standard Clocks
In-Reply-To: <57174151.8040806@baylibre.com>
References: <1460973696-5977-1-git-send-email-narmstrong@baylibre.com>
 <1460973696-5977-2-git-send-email-narmstrong@baylibre.com>
 <20160419212944.GF15324@codeaurora.org>
 <57174151.8040806@baylibre.com>
Message-ID: <20160420184044.GJ15324@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20, Neil Armstrong wrote:
> On 04/19/2016 11:29 PM, Stephen Boyd wrote:
> > On 04/18, Neil Armstrong wrote:
> >> +		struct clk_oxnas *_clk;
> >> +
> >> +		if (!clk_oxnas_init[i].clk_init)
> >> +			continue;
> > 
> > New design is fine, really it's up to you, but then this check
> > isn't needed anymore, right?
> > 
> 
> it's not needed for sure, but do I need to send a v3 to remove this ?
> 

No worries. I'll remove these two lines while applying.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
