From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Jul 2018 08:53:06 +0100
Subject: [PATCH v3 2/5] mfd: axp20x: Add self-working mode support for
 AXP806
In-Reply-To: <20180712160452.5516-3-wens@csie.org>
References: <20180712160452.5516-1-wens@csie.org>
 <20180712160452.5516-3-wens@csie.org>
Message-ID: <20180713075306.GY4641@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jul 2018, Chen-Yu Tsai wrote:

> The AXP806 can operate in a standalone "self-working" mode, in which it
> is also responsible for power control of the overall system. This mode
> is similar to the master mode, but the EN/PWRON pin functions as a power
> button, instead of a level-triggered enable switch.
> 
> This patch adds code checking for the new "x-powers,self-working-mode"
> property, and a separate mfd_cell list that includes the power button
> (PEK) sub-device.
> 
> Reviewed-by: Icenowy Zheng <icenowy@aosc.io>
> Tested-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
