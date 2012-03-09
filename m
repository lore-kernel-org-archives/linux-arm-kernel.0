From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 9 Mar 2012 16:25:28 +0800
Subject: [PATCH v11] Regulator: Add Anatop regulator driver
In-Reply-To: <1331279829-4584-1-git-send-email-paul.liu@linaro.org>
References: <1331279829-4584-1-git-send-email-paul.liu@linaro.org>
Message-ID: <CAF+7xWkA-rDML03U=7d30ipXV9buhbqnZYWS54nGVKZbkYxXJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/3/9 Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>:
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
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Axel Lin <axel.lin@gmail.com>

The rdesc->n_voltage setting is missing.
Otherwise, Reviewed-by: Axel Lin <axel.lin@gmail.com>
