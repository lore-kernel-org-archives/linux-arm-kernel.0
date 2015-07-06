From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 6 Jul 2015 15:07:13 -0700
Subject: [PATCH 2/7] clk: rockchip: fix issues in the mmc-phase clock
In-Reply-To: <1436086820-3757-3-git-send-email-heiko@sntech.de>
References: <1436086820-3757-1-git-send-email-heiko@sntech.de>
 <1436086820-3757-3-git-send-email-heiko@sntech.de>
Message-ID: <20150706220713.GH20866@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05, Heiko Stuebner wrote:
> The review for the new inverter clock type uncovered some issues (missing
> headers and name handling) that are also present in the mmc-phase clock
> type, I got (to much) inspiration from. Fix these there too.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-rk3368.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
