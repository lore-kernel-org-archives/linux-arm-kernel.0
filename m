From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 16:34:12 -0800
Subject: [PATCH v6 3/3] clk: at91: pmc: Support backup for programmable
 clocks
In-Reply-To: <20171211165535.5126-4-romain.izard.pro@gmail.com>
References: <20171211165535.5126-1-romain.izard.pro@gmail.com>
 <20171211165535.5126-4-romain.izard.pro@gmail.com>
Message-ID: <20171222003412.GX7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11, Romain Izard wrote:
> When an AT91 programmable clock is declared in the device tree, register
> it into the Power Management Controller driver. On entering suspend mode,
> the driver saves and restores the Programmable Clock registers to support
> the backup mode for these clocks.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
