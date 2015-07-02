From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jul 2015 09:59:15 -0700
Subject: [PATCH 8/9] drivers: clk: st: Rename st_pll3200c32_407_c0_x into
 st_pll3200c32_cx_x
In-Reply-To: <1435068567-30995-9-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
 <1435068567-30995-9-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20150702165914.GE7201@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23, Gabriel Fernandez wrote:
> Use a generic name for this kind of PLL
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>

Is this just a cleanup/nicety? I could take this patch but patch
9 needs to go through arm-soc and then we have to deal with DT
incompatibility. How about we drop these last two patches?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
