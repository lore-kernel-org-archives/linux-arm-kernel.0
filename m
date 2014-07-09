From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 9 Jul 2014 16:31:46 +0100
Subject: [PATCH v7 18/24] mfd: max77686: Add Maxim 77802 PMIC support
In-Reply-To: <1404505467-26526-19-git-send-email-javier.martinez@collabora.co.uk>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
 <1404505467-26526-19-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140709153146.GJ2635@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 04 Jul 2014, Javier Martinez Canillas wrote:
> Maxim MAX77802 is a power management chip that contains 10 high
> efficiency Buck regulators, 32 Low-dropout (LDO) regulators used
> to power up application processors and peripherals, a 2-channel
> 32kHz clock outputs, a Real-Time-Clock (RTC) and a I2C interface
> to program the individual regulators, clocks outputs and the RTC.
> 
> This patch adds support for MAX77802 to the MAX77686 driver and is
> based on a driver added to the Chrome OS kernel 3.8 by Simon Glass.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

[...]

>  static const struct i2c_device_id max77686_i2c_id[] = {
>  	{ "max77686", TYPE_MAX77686 },
> +	{ "max77802", TYPE_MAX77802 },
>  	{ }

There's no point in filling this in.  Just empty it completely.

Once you've done that, resubmit the patchset with my:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
