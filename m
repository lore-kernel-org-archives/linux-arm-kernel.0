From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 2 Oct 2015 12:32:38 -0700
Subject: [PATCH v2 2/4] drivers: clk: st: PLL rate change implementation
 for DVFS
In-Reply-To: <1440409251-11166-3-git-send-email-gabriel.fernandez@linaro.org>
References: <1440409251-11166-1-git-send-email-gabriel.fernandez@linaro.org>
 <1440409251-11166-3-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20151002193238.GU12338@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24, Gabriel Fernandez wrote:
> Change A9 PLL rate, as per requirement from the cpufreq framework,
> for DVFS. For rate change, the A9 clock needs to be temporarily sourced
> from PLL external to A9 and then sourced back to A9-PLL
> 
> Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
