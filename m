From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 2 Jun 2017 15:40:34 -0700
Subject: [PATCH V3 0/3] clk: introduce clk_bulk_get accessories
In-Reply-To: <1495201746-31841-1-git-send-email-aisheng.dong@nxp.com>
References: <1495201746-31841-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170602224034.GX20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19, Dong Aisheng wrote:
> These helper function allows drivers to get several clk consumers in
> one operation.  If any of the clk cannot be acquired then any clks
> that were got will be put before returning to the caller.
> 

I've merged the first two into a stable branch and merged to
clk-next. The third one can go via cpufreq.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
