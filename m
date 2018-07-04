From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 04 Jul 2018 12:08:15 +0200
Subject: [PATCH v3 0/4] clk: rockchip: support clock controller for px30
 SoC
In-Reply-To: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
References: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <19643053.9AiPb2dtV0@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Freitag, 15. Juni 2018, 04:16:47 CEST schrieb Elaine Zhang:
> Change in V3:
> [PATCH v3 1/4]: Correct description
> [PATCH v3 2/4]: Use an SPDX tag instead.
> [PATCH v3 3/4]: Use an SPDX tag instead,
> 		parent_rate might overflow and fix it.
> 		fix up the checkpatch warning.
> 		add more CMPOSITE_xxx_HALFdiv.
> 
> Change in V2:
> [PATCH v2 2/4]: modify the Author name
> [PATCH v2 3/4]: provide a bit more explanation for commit message
> 
> Elaine Zhang (4):
>   dt-bindings: add bindings for px30 clock controller
>   clk: rockchip: add dt-binding header for px30
>   clk: rockchip: add support for half divider
>   clk: rockchip: add clock controller for px30

I've applied the set for 4.19 but dropped the panic-notifier
dump function from the px30 clock driver.

Heiko
