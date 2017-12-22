From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 17:55:07 -0800
Subject: [PATCH V2 02/10] clk: reparent orphans after critical clocks
 enabled
In-Reply-To: <20171221183233.GK7997@codeaurora.org>
References: <1499946435-7177-1-git-send-email-aisheng.dong@nxp.com>
 <1499946435-7177-3-git-send-email-aisheng.dong@nxp.com>
 <20171102073609.GT30645@codeaurora.org>
 <20171220143322.GC30461@b29396-OptiPlex-7040>
 <20171221183233.GK7997@codeaurora.org>
Message-ID: <20171222015507.GE7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21, Stephen Boyd wrote:
> 
> Ok. Great. I'm going to apply this patch now into clk-next to
> look for regressions on other platforms. If this was the only
> questionable thing about this series then I think I can apply the
> rest of it without you needing to resend. I'll check today.
> 

I pushed it into clk-imx7ulp and merged that into clk-next. You
can use that patch in your series.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
