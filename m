From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 3 Mar 2016 11:37:34 -0800
Subject: [PATCH] clk: xgene: Add missing parenthesis when clearing
 divider value
In-Reply-To: <1456780543-13770-1-git-send-email-lho@apm.com>
References: <1456780543-13770-1-git-send-email-lho@apm.com>
Message-ID: <20160303193734.GB24999@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29, Loc Ho wrote:
> In the initial fix for non-zero divider shift value, the parenthesis
> was missing after the negate operation. This patch adds the required
> parenthesis. Otherwise, lower bits may be cleared unintentionally.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Acked-by: Toan Le <toanle@apm.com>
> ---

Applied to clk-next + added a fixes tag.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
