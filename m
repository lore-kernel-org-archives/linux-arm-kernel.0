From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 09:23:33 +0200
Subject: [PATCH v9 01/20] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
In-Reply-To: <1460347078-15175-2-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <1460347078-15175-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <570CA275.6000903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2016 05:57 AM, Chanwoo Choi wrote:
> This patch adds the generic exynos bus frequency driver for AMBA AXI bus
> of sub-blocks in exynos SoC with DEVFREQ framework. The Samsung Exynos SoC
> have the common architecture for bus between DRAM and sub-blocks in SoC.
> This driver can support the generic bus frequency driver for Exynos SoCs.
> 
> In devicetree, Each bus block has a bus clock, regulator, operation-point
> and devfreq-event devices which measure the utilization of each bus block.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> [m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/devfreq/Kconfig      |  15 ++
>  drivers/devfreq/Makefile     |   1 +
>  drivers/devfreq/exynos-bus.c | 443 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 459 insertions(+)
>  create mode 100644 drivers/devfreq/exynos-bus.c

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
