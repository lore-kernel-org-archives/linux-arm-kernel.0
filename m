From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Jun 2016 11:57:15 -0700
Subject: [PATCH 2/5] ARM: dts: add SDCC5 to Qualcomm MSM8660
In-Reply-To: <1465918259-11138-3-git-send-email-linus.walleij@linaro.org>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
 <1465918259-11138-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160614185715.GI28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14, Linus Walleij wrote:
> The SDCC5 SD/MMC controller is used for a second uSD slot
> on the APQ8060 Dragonboard. On most other systems it is just
> dark silicon so define it and leave it as "disabled" in the core
> SoC file.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
