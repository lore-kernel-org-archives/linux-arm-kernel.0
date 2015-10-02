From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 1 Oct 2015 17:13:01 -0700
Subject: [PATCH v3 1/4] clk: bcm2835: Move under bcm/ with other Broadcom
 SoC clk drivers.
In-Reply-To: <1443475325-22270-1-git-send-email-eric@anholt.net>
References: <1443475325-22270-1-git-send-email-eric@anholt.net>
Message-ID: <20151002001301.GB1213@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28, Eric Anholt wrote:
> clk-bcm2835.c predates the drivers under bcm/, but all the new BCM
> drivers are going in there so let's follow them.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> ---

Applied to clk-bcm2385 and merged into clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
