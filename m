From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 7 Oct 2015 12:14:59 -0700
Subject: [PATCH v4 2/4] drivers: clk: st: PLL rate change implementation
 for DVFS
In-Reply-To: <1444208939-10233-3-git-send-email-gabriel.fernandez@linaro.org>
References: <1444208939-10233-1-git-send-email-gabriel.fernandez@linaro.org>
 <1444208939-10233-3-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20151007191459.GB12345@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07, Gabriel Fernandez wrote:
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
