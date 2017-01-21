From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 16:33:15 -0800
Subject: [PATCH 4/8] clk: renesas: cpg-mssr: Add support for reset control
In-Reply-To: <1484921306-9967-5-git-send-email-geert+renesas@glider.be>
References: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
 <1484921306-9967-5-git-send-email-geert+renesas@glider.be>
Message-ID: <20170121003315.GV20800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20, Geert Uytterhoeven wrote:
> Add optional support for the Reset Control feature of the Renesas Clock
> Pulse Generator / Module Standby and Software Reset module on R-Car
> Gen2, R-Car Gen3, and RZ/G1 SoCs.
> 
> This allows to reset SoC devices using the Reset Controller API.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
