From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jul 2015 15:51:31 -0700
Subject: [PATCH v2 2/9] clk: rockchip: fix faulty vip parent name on rk3288
In-Reply-To: <1434637116-17124-3-git-send-email-heiko@sntech.de>
References: <1434637116-17124-1-git-send-email-heiko@sntech.de>
 <1434637116-17124-3-git-send-email-heiko@sntech.de>
Message-ID: <20150702225131.GL4301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18, Heiko Stuebner wrote:
> The video input processor (vip) was called camera interface (cif) on
> older socs which seems to have resulted in a copy'n'paste error when
> creating the rk3288 camera clocks.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-rk3368

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
