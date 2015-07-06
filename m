From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 6 Jul 2015 15:11:25 -0700
Subject: [PATCH 5/7] clk: rockchip: add dt-binding header for rk3368
In-Reply-To: <1436086820-3757-6-git-send-email-heiko@sntech.de>
References: <1436086820-3757-1-git-send-email-heiko@sntech.de>
 <1436086820-3757-6-git-send-email-heiko@sntech.de>
Message-ID: <20150706221125.GK20866@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05, Heiko Stuebner wrote:
> Add the dt-bindings header for the rk3368, that gets shared between
> the clock controller and the clock references in the dts.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> I only need this dt-binding header in a stable branch to be included
> into armsoc.
> 

Applied to clk-rk3368. It will be stable now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
