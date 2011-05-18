From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 18 May 2011 15:35:38 -0700
Subject: [PATCH 7/7] gpio_msm: Move Qualcomm MSM v2 gpio driver into
	drivers
In-Reply-To: <1305755453-31112-8-git-send-email-davidb@codeaurora.org>
References: <1305755453-31112-1-git-send-email-davidb@codeaurora.org>
	<1305755453-31112-8-git-send-email-davidb@codeaurora.org>
Message-ID: <4DD449BA.3090907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2011 02:50 PM, David Brown wrote:
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index aa5a3f9..235b6c9 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -139,6 +139,14 @@ config GPIO_MSM_V1
>  	  Qualcomm MSM chips.  Most of the pins on the MSM can be
>  	  selected for GPIO, and are controlled by this driver.
>  
> +config GPIO_MSM_V2
> +	tristate "Qualcomm MSM GPIO v2"
> +	depends on GPIOLIB && ARCH_MSM
> +	help
> +	  Say yes here to support the GPIO interface on ARM many v7

s/many// ?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
