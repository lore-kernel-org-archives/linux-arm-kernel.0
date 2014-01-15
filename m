From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Jan 2014 11:03:58 -0800
Subject: [PATCH v4 02/15] clk: Allow drivers to pass in a regmap
In-Reply-To: <20140115092857.4167.38854@quantum>
References: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
 <1387847559-18330-3-git-send-email-sboyd@codeaurora.org>
 <20140109015158.7168.60274@quantum>
 <52CE055C.5030103@codeaurora.org>
 <20140110054424.7168.46289@quantum>
 <20140110070517.GE14405@codeaurora.org>
 <20140115092857.4167.38854@quantum>
Message-ID: <20140115190358.GA26193@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15, Mike Turquette wrote:
> 
> So in summary: consolidation is over-rated. You can put your regmap
> functions into drivers/clk/msm/ and not convert over to struct clk_desc
> by the way, just to remove any confusion on that point.
> 

Ok I've made the wrapper struct clk_regmap and posted the
patches. I think I've addressed all your concerns.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
