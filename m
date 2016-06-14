From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Jun 2016 11:55:56 -0700
Subject: [PATCH 4/5] ARM: dts: move the fixed MMC regulator to SURF board
In-Reply-To: <1465918259-11138-5-git-send-email-linus.walleij@linaro.org>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
 <1465918259-11138-5-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160614185556.GH28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14, Linus Walleij wrote:
> There is currently a fixed regulator in the .dtsi file for
> the MSM8660 chipset, used by the SURF board. We want to define
> real regulators for a board using this chipset, so push the fixed
> regulator down to the SURF board which is the only user.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
