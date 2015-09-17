From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 17 Sep 2015 11:51:51 -0700
Subject: [PATCH 2/2] drivers: clk: st: Rename st_pll3200c32_407_c0_x into
 st_pll3200c32_cx_x
In-Reply-To: <1442389379-9298-3-git-send-email-gabriel.fernandez@linaro.org>
References: <1442389379-9298-1-git-send-email-gabriel.fernandez@linaro.org>
 <1442389379-9298-3-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20150917185151.GT23081@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16, Gabriel Fernandez wrote:
> Use a generic name for this kind of PLL
> 
> Correction in dts files are already done here:
> commit 5eb26c605909 ("ARM: STi: DT: Rename st_pll3200c32_407_c0_x into st_pll3200c32_cx_x")
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
