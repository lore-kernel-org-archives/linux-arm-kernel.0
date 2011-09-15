From: ben-i2c@fluff.org (Ben Dooks)
Date: Thu, 15 Sep 2011 16:50:05 +0100
Subject: [PATCH v3 0/2] Add device tree probe for i2c-imx driver
In-Reply-To: <1316101193-4295-1-git-send-email-shawn.guo@linaro.org>
References: <1316101193-4295-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110915155005.GI19115@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 11:39:51PM +0800, Shawn Guo wrote:
> Hi Ben,
> 
> Hopefully, you can pick up this version.

ok, will do it for the weekend.
 
> Thanks.
> 
> Changes since v2:
>  * Drop HS-I2C from binding document fsl-imx-i2c.txt
> 
> Changes since v1:
>  * Fix a couple of typo in fsl-imx-i2c.txt
> 
> Shawn Guo (2):
>       i2c-imx: remove init/exit hooks from platform data
>       i2c-imx: add device tree probe support
> 
>  .../devicetree/bindings/i2c/fsl-imx-i2c.txt        |   18 ++++++++
>  arch/arm/plat-mxc/include/mach/i2c.h               |    4 --
>  drivers/i2c/busses/i2c-imx.c                       |   46 +++++++++----------
>  3 files changed, 40 insertions(+), 28 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
