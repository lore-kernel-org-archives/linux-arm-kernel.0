From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Apr 2016 15:16:23 -0700
Subject: [PATCH v3 01/19] clk: composite: Add unregister function
In-Reply-To: <20160419095250.GA26050@lukather>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160415222856.GQ14441@codeaurora.org>
 <20160419095250.GA26050@lukather>
Message-ID: <20160421221623.GC13149@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19, Maxime Ripard wrote:
> 
> I have a bunch of other clock patches that need this, so I guess it
> would be easier if applied it directly with your acked-by, or if you
> could apply it and give a stable branch I can base my future PR on.

Ok. I pushed it to stable branch 'clk-composite-unregister' in
the clk.git repo. That way I can go ahead and delete this API
assuming I get around to converting all the composite users in
the next few days.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
