From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 12 Oct 2016 00:00:12 +0200
Subject: [PATCH v1 1/2] include: dt-bindings: Add GPIO pin index
 definition for rockchip pinctrl
In-Reply-To: <1473210053-23743-1-git-send-email-andy.yan@rock-chips.com>
References: <1473210053-23743-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <13068948.jkWM1OvpR7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 7. September 2016, 09:00:53 CEST schrieb Andy Yan:
> Add gpio pin index definition to make it easier to describe
> GPIO in dts.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

just as a heads up, as I didn't respond yet:

Looks good and I'll take them, I just want to wait for the merge-window to 
close (should be the coming sunday), to be able to put the header change in a 
shared branch for the case that other users appear during the 4.10 cycle.


Heiko

> ---
> 
> Changes in v1:
> - remove gpio bank definition RK_GPIO7/8
> - redefine GPIO PIN as RK_PA/B/C/Dx
> 
>  include/dt-bindings/pinctrl/rockchip.h | 33
> +++++++++++++++++++++++++++++++++ 1 file changed, 33 insertions(+)
> 
> diff --git a/include/dt-bindings/pinctrl/rockchip.h
> b/include/dt-bindings/pinctrl/rockchip.h index 743e66a..aaec8ba 100644
> --- a/include/dt-bindings/pinctrl/rockchip.h
> +++ b/include/dt-bindings/pinctrl/rockchip.h
> @@ -25,6 +25,39 @@
>  #define RK_GPIO4	4
>  #define RK_GPIO6	6
> 
> +#define RK_PA0		0
> +#define RK_PA1		1
> +#define RK_PA2		2
> +#define RK_PA3		3
> +#define RK_PA4		4
> +#define RK_PA5		5
> +#define RK_PA6		6
> +#define RK_PA7		7
> +#define RK_PB0		8
> +#define RK_PB1		9
> +#define RK_PB2		10
> +#define RK_PB3		11
> +#define RK_PB4		12
> +#define RK_PB5		13
> +#define RK_PB6		14
> +#define RK_PB7		15
> +#define RK_PC0		16
> +#define RK_PC1		17
> +#define RK_PC2		18
> +#define RK_PC3		19
> +#define RK_PC4		20
> +#define RK_PC5		21
> +#define RK_PC6		22
> +#define RK_PC7		23
> +#define RK_PD0		24
> +#define RK_PD1		25
> +#define RK_PD2		26
> +#define RK_PD3		27
> +#define RK_PD4		28
> +#define RK_PD5		29
> +#define RK_PD6		30
> +#define RK_PD7		31
> +
>  #define RK_FUNC_GPIO	0
>  #define RK_FUNC_1	1
>  #define RK_FUNC_2	2
