From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 13 Jul 2017 01:44:18 +0200
Subject: [RESEND PATCH v2 5/7] ARM: dts: rockchip: add sdmmc and sdio
 nodes for rk3228 SoC
In-Reply-To: <1498127524-6837-1-git-send-email-frank.wang@rock-chips.com>
References: <1498127402-6705-1-git-send-email-frank.wang@rock-chips.com>
 <1498127524-6837-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <2561875.EGPHYCLJk3@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 22. Juni 2017, 18:32:04 CEST schrieb Frank Wang:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> This patch adds sdmmc/sdio controller nodes for rk3228 SoC.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

applied for 4.14 after changing
- RK_FUNC_1 to 1
- pin numbers to their constants (21 -> RK_PC5) etc.


Heiko
