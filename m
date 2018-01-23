From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Jan 2018 09:54:08 +0000
Subject: [PATCH v3 06/16] mfd: axp20x: make AXP209/22x cells probe their
 ADC via DT
In-Reply-To: <8901f920fb8d84f8bf0cb2832f560c78bffc0392.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
 <8901f920fb8d84f8bf0cb2832f560c78bffc0392.1516012352.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20180123095408.zin3tcxf37j2wu7i@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Jan 2018, Quentin Schulz wrote:

> This makes AXP209 and AXP22x ADCs probe first via DT and then by
> fallback via platform.
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
