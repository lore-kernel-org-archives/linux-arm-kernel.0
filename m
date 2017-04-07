From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 7 Apr 2017 12:16:32 -0700
Subject: [PATCH v3] clk: imx: clk-imx6ul: The i.mx6ul has no aips_tz3 clock
In-Reply-To: <20170303141405.17581-1-robin@protonic.nl>
References: <20170303141405.17581-1-robin@protonic.nl>
Message-ID: <20170407191632.GX7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03, Robin van der Gracht wrote:
> The clock was mapped on CG15 (gpio2_clocks) in the CCRG0 register.
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
