From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 1 Nov 2018 11:18:27 -0500
Subject: [PATCH v2 0/2] i2c-omap: Enable i2c-omap driver for AM654 SoCs
In-Reply-To: <20180928052557.21663-1-vigneshr@ti.com>
References: <20180928052557.21663-1-vigneshr@ti.com>
Message-ID: <370a3812-b1f4-eb2a-2775-38684be4c525@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/28/18 12:25 AM, Vignesh R wrote:
> Couple of patches to enable i2c-omap driver to be used with TI's new
> AM654 platforms.
> 
> 
> Vignesh R (2):
>    dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
>    i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3
> 
>   Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
>   drivers/i2c/busses/Kconfig                         | 2 +-
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
