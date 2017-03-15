From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 15 Mar 2017 11:06:08 +0000
Subject: [PATCHv2 4/5] mfd: altr_a10sr: Add Arria10 DevKit Reset Controller
In-Reply-To: <1487783419-10912-5-git-send-email-thor.thayer@linux.intel.com>
References: <1487783419-10912-1-git-send-email-thor.thayer@linux.intel.com>
 <1487783419-10912-5-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <20170315110608.5qgyj5pwsr7lr6zz@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Feb 2017, thor.thayer at linux.intel.com wrote:

> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add Peripheral PHY Reset Controller to the Arria10
> Development Kit System Resource Chip's MFD.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  Changes to commit header & body for clarification.
> ---
>  drivers/mfd/altera-a10sr.c | 4 ++++
>  1 file changed, 4 insertions(+)

Sorry for the delay, I've been AFK on vacation and conferences.

Applied, thanks.

> diff --git a/drivers/mfd/altera-a10sr.c b/drivers/mfd/altera-a10sr.c
> index 06e1f7f..96e7d2c 100644
> --- a/drivers/mfd/altera-a10sr.c
> +++ b/drivers/mfd/altera-a10sr.c
> @@ -33,6 +33,10 @@
>  		.name = "altr_a10sr_gpio",
>  		.of_compatible = "altr,a10sr-gpio",
>  	},
> +	{
> +		.name = "altr_a10sr_reset",
> +		.of_compatible = "altr,a10sr-reset",
> +	},
>  };
>  
>  static bool altr_a10sr_reg_readable(struct device *dev, unsigned int reg)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
