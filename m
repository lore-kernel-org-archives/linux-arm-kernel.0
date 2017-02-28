From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 28 Feb 2017 15:42:21 +0100
Subject: [PATCHv2 4/5] mfd: altr_a10sr: Add Arria10 DevKit Reset Controller
In-Reply-To: <1487783419-10912-5-git-send-email-thor.thayer@linux.intel.com>
References: <1487783419-10912-1-git-send-email-thor.thayer@linux.intel.com>
 <1487783419-10912-5-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1488292941.2288.55.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-02-22 at 11:10 -0600, thor.thayer at linux.intel.com wrote:
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
> 
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

Lee, should this be merged through the reset tree? Otherwise I'll just
pick up patches 1-3.

regards
Philipp
