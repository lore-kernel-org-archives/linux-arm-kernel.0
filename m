From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Apr 2017 09:11:13 -0700
Subject: [PATCH 1/2] clk: clk-imx7d: fix ahb clk definition
In-Reply-To: <1491878269-9559-1-git-send-email-aisheng.dong@nxp.com>
References: <1491878269-9559-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170419161113.GY7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11, Dong Aisheng wrote:
> MX7D ahb clk actually has no LPCG gate, current LPCG offset 0x4200
> used actually is for adc, not ahb. After fix, correct ocram_s_clk
> parent accordingly as well.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
