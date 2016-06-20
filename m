From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Jun 2016 16:38:20 -0700
Subject: [PATCH 5/7] ARM: dts: fix the MSM8660 RTC base address
In-Reply-To: <1466195292-28236-7-git-send-email-linus.walleij@linaro.org>
References: <1466195292-28236-1-git-send-email-linus.walleij@linaro.org>
 <1466195292-28236-7-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160620233820.GA14735@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17, Linus Walleij wrote:
> The RTC was defined on 0x11d but on the MSM8660/APQ8060 it is
> actually on 0x1e8. We were saved by the fact that the driver does
> not use the reg parameter: instead it uses the compatible string
> to figure out where the RTC is.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
