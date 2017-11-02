From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Nov 2017 00:28:02 -0700
Subject: [PATCH RESEND 2/2] clk: imx: imx7d: Remove ARM_M0 clock
In-Reply-To: <1506940331-16742-3-git-send-email-adriana.reus@nxp.com>
References: <1506940331-16742-1-git-send-email-adriana.reus@nxp.com>
 <1506940331-16742-3-git-send-email-adriana.reus@nxp.com>
Message-ID: <20171102072802.GS30645@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02, Adriana Reus wrote:
> IMX7d does not have an M0 Core and this particular
> clock doesn't seem connected to anything else.
> Remove this entry from the CCM driver.
> 
> Signed-off-by: Adriana Reus <adriana.reus@nxp.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
