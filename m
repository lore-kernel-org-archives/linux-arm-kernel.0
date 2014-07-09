From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 09 Jul 2014 20:43:47 +0200
Subject: [PATCH v7 18/24] mfd: max77686: Add Maxim 77802 PMIC support
In-Reply-To: <20140709153146.GJ2635@lee--X1>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
 <1404505467-26526-19-git-send-email-javier.martinez@collabora.co.uk>
 <20140709153146.GJ2635@lee--X1>
Message-ID: <53BD8D63.1080005@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

On 07/09/2014 05:31 PM, Lee Jones wrote:
> On Fri, 04 Jul 2014, Javier Martinez Canillas wrote:
>> Maxim MAX77802 is a power management chip that contains 10 high
>> efficiency Buck regulators, 32 Low-dropout (LDO) regulators used
>> to power up application processors and peripherals, a 2-channel
>> 32kHz clock outputs, a Real-Time-Clock (RTC) and a I2C interface
>> to program the individual regulators, clocks outputs and the RTC.
>> 
>> This patch adds support for MAX77802 to the MAX77686 driver and is
>> based on a driver added to the Chrome OS kernel 3.8 by Simon Glass.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
> 
> [...]
> 
>>  static const struct i2c_device_id max77686_i2c_id[] = {
>>  	{ "max77686", TYPE_MAX77686 },
>> +	{ "max77802", TYPE_MAX77802 },
>>  	{ }
> 
> There's no point in filling this in.  Just empty it completely.
> 

Ok, I won't fill this

> Once you've done that, resubmit the patchset with my:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 

Thanks a lot.

Best regards,
Javier
