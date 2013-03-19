From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 19 Mar 2013 13:09:22 -0700
Subject: [PATCH v3] clk: Add axi-clkgen driver
In-Reply-To: <1363015349-7394-1-git-send-email-lars@metafoo.de>
References: <1363015349-7394-1-git-send-email-lars@metafoo.de>
Message-ID: <20130319200922.8663.6535@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lars-Peter Clausen (2013-03-11 08:22:29)
> This driver adds support for the AXI clkgen pcore to the common clock framework.
> The AXI clkgen pcore is a AXI front-end to the MMCM_ADV frequency synthesizer
> commonly found in Xilinx FPGAs.
> 
> The AXI clkgen pcore is used in Analog Devices' reference designs targeting
> Xilinx FPGAs.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> ---
> Changes since v2:
>         * Use devm_ioremap_resource() instead of devm_request_and_ioremap()
> 
> Changes since v1:
>         * Fix error in the filter coef lookup table
>         * Use unsigend long long arithmetic to avoid overflow when calculating the
>           current clock frequency.
>         * Use readl/writel instead of ioread32/iowrite32
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Taken into clk-next.

Thanks,
Mike
