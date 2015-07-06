From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 6 Jul 2015 15:08:10 -0700
Subject: [PATCH 3/7] clk: rockchip: define the inverters of rk3066/rk3188
 and rk3288
In-Reply-To: <1436086820-3757-4-git-send-email-heiko@sntech.de>
References: <1436086820-3757-1-git-send-email-heiko@sntech.de>
 <1436086820-3757-4-git-send-email-heiko@sntech.de>
Message-ID: <20150706220810.GI20866@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05, Heiko Stuebner wrote:
> Both soc series' have inverters on the hsadc and camera interface clock
> paths. So define them using the newly added inverter type.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-rk3368.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
