From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Jun 2014 09:29:53 +0100
Subject: [PATCH v2 16/20] mfd: sun6i-prcm: Add support for Allwinner A23
 PRCM
In-Reply-To: <1403016777-15121-17-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-17-git-send-email-wens@csie.org>
Message-ID: <20140618082953.GO21030@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The Allwinner A23 SoC has a PRCM unit like the previous A31 SoC.
> The differences are the AR100 clock can no longer be modified,
> the APB0 clock has different divisors, and some clock gates are
> gone.
> 
> This patch adds a compatible with a modified subdevice list for
> the A23.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/mfd/sun6i-prcm.txt         |  2 +-
>  drivers/mfd/sun6i-prcm.c                           | 30 ++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)

The patch looks fine to me, but I'm concerned about the size of the
patch set and the amount of subsystems it touches.

I am guessing that this patch can just be taken independently though.
Please correct me if I'm wrong.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
