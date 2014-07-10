From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 10 Jul 2014 10:37:07 +0100
Subject: [PATCH v4 3/6] mfd: sun6i-prcm: Add support for Allwinner A23 PRCM
In-Reply-To: <1404892479-12222-4-git-send-email-wens@csie.org>
References: <1404892479-12222-1-git-send-email-wens@csie.org>
 <1404892479-12222-4-git-send-email-wens@csie.org>
Message-ID: <20140710093707.GC11948@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 09 Jul 2014, Chen-Yu Tsai wrote:

> The Allwinner A23 SoC has a PRCM unit like the previous A31 SoC.
> The differences are the AR100 clock can no longer be modified,
> the APB0 clock has different divisors, and some clock gates are
> gone.
> 
> This patch adds a compatible with a modified subdevice list for
> the A23.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../devicetree/bindings/mfd/sun6i-prcm.txt         |  2 +-
>  drivers/mfd/sun6i-prcm.c                           | 30 ++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
