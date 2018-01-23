From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Jan 2018 09:53:05 +0000
Subject: [PATCH v3 09/16] mfd: axp20x: probe axp20x_adc driver for AXP813
In-Reply-To: <d5792ed6e1e989dde3c9ecdd018286109dfc101d.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
 <d5792ed6e1e989dde3c9ecdd018286109dfc101d.1516012352.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20180123095305.lgxpq5gyzlo5cked@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Jan 2018, Quentin Schulz wrote:

> This makes the axp20x_adc driver probe with platform device id
> "axp813-adc".
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
