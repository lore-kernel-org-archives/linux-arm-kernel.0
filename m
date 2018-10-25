From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2018 10:36:07 +0100
Subject: [PATCH v5 2/5] regulator: rk808: add RK809 and RK817 support.
In-Reply-To: <1540294467-25813-3-git-send-email-tony.xie@rock-chips.com>
References: <1540294467-25813-1-git-send-email-tony.xie@rock-chips.com>
 <1540294467-25813-3-git-send-email-tony.xie@rock-chips.com>
Message-ID: <20181025093607.GO4939@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018, Tony Xie wrote:

>     Add support for the rk809 and rk817 regulator driver.
>     Their specifications are as follows?
>     1. The RK809 and RK809 consist of 5 DCDCs, 9 LDOs
>        and have the same registers for these components except dcdc5.
>     2. The dcdc5 is a boost dcdc for RK817 and is a buck for RK809.
>     3. The RK817 has one switch but The Rk809 has two.
> 
>     The output voltages are configurable and are meant to supply power
>     to the main processor and other components.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---
>  drivers/regulator/Kconfig           |   4 +-
>  drivers/regulator/rk808-regulator.c | 657 ++++++++++++++++++++++++++++++++++--

>  include/linux/mfd/rk808.h           |   3 +

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
