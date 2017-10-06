From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 6 Oct 2017 13:06:33 -0700
Subject: [PATCH v2 05/10] clk: bcm: Add Broadcom Hurricane 2 clock support
In-Reply-To: <20170928231502.27069-6-f.fainelli@gmail.com>
References: <20170928231502.27069-1-f.fainelli@gmail.com>
 <20170928231502.27069-6-f.fainelli@gmail.com>
Message-ID: <20171006200633.GI457@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28, Florian Fainelli wrote:
> Add support for the Broadcom Hurricane 2 SoC clock controller. We can
> re-use the existing iProc clock library since the SoC's architecture is
> largely the same as its predecessors. For now, we just initialize the
> iProc ARM PLL.
> 
> Acked-by: Jon Mason <jon.mason@broadcom.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
