From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jul 2015 09:59:43 -0700
Subject: [PATCH 4/9] drivers: clk: st: Fix FSYN channel values
In-Reply-To: <1435068567-30995-5-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
 <1435068567-30995-5-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20150702165943.GB4301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23, Gabriel Fernandez wrote:
> This patch fixes the value for disabling the FSYN channel clock.
> The 'is_enabled' returned value is also fixed.
> 
> Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
