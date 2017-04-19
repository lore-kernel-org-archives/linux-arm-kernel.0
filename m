From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Apr 2017 09:11:16 -0700
Subject: [PATCH 2/2] clk: imx7d: add the missing ipg_root_clk
In-Reply-To: <1491878269-9559-2-git-send-email-aisheng.dong@nxp.com>
References: <1491878269-9559-1-git-send-email-aisheng.dong@nxp.com>
 <1491878269-9559-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170419161116.GZ7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11, Dong Aisheng wrote:
> Add the missing ipg_root_clk which actually is already used by many
> orphan clks in current tree.
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
