From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Mar 2012 13:24:51 +0800
Subject: [PATCH v13] Regulator: Add Anatop regulator driver
In-Reply-To: <1331692152-9256-1-git-send-email-paul.liu@linaro.org>
References: <1331692152-9256-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120322052449.GB2213@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 10:29:12AM +0800, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> 
> Anatop is an integrated regulator inside i.MX6 SoC.
> There are 3 digital regulators which controls PU, CORE (ARM), and SOC.
> And 3 analog regulators which controls 1P1, 2P5, 3P0 (USB).
> This patch adds the Anatop regulator driver.
> 
> Signed-off-by: Nancy Chen <Nancy.Chen@freescale.com>
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Axel Lin <axel.lin@gmail.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  drivers/regulator/Kconfig            |    8 +
>  drivers/regulator/Makefile           |    1 +
>  drivers/regulator/anatop-regulator.c |  241 ++++++++++++++++++++++++++++++++++
>  3 files changed, 250 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/regulator/anatop-regulator.c
> 
I just noticed that the binding document below got lost since v11 of
the series.

  Documentation/devicetree/bindings/regulator/anatop-regulator.txt

It got lost by mistaken or you dropped it for some reason?

-- 
Regards,
Shawn
