From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 31 Jul 2014 09:36:11 +0100
Subject: [PATCH 1/2] mfd: twl-core: move TWL6030 defines to twl.h
In-Reply-To: <1406728949-7560-2-git-send-email-sassmann@kpanic.de>
References: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
 <1406728949-7560-2-git-send-email-sassmann@kpanic.de>
Message-ID: <20140731083611.GI9030@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jul 2014, Stefan Assmann wrote:

> These defines should be available to all drivers. Also added register
> offset for CLK32KG_CFG_STATE and GRP defines.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/regulator/twl-regulator.c | 11 -----------
>  include/linux/i2c/twl.h           | 20 ++++++++++++++++++++
>  2 files changed, 20 insertions(+), 11 deletions(-)

This doesn't have anything to do with MFD?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
