From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 10:49:07 -0800
Subject: [PATCH] clk: xgene: Fix divider with non-zero shift value
In-Reply-To: <1447960830-8675-1-git-send-email-lho@apm.com>
References: <1447960830-8675-1-git-send-email-lho@apm.com>
Message-ID: <20151120184907.GU32672@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19, Loc Ho wrote:
> The X-Gene clock driver missed the divider shift operation when
> set the divider value.
> 
> Signed-off-by: Loc Ho <lho@apm.com>

Applied to clk-next + 

Fixes: 308964caeebc ("clk: Add APM X-Gene SoC clock driver")

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
