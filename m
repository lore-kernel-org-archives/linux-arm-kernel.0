From: a0393675@ti.com (Keerthy)
Date: Tue, 24 May 2016 09:26:45 +0530
Subject: [PATCH 3/3] ARM: configs: keystone: Enable PINCTRL_SINGLE Config
In-Reply-To: <5743CC80.4070404@ti.com>
References: <1464006547-19569-1-git-send-email-j-keerthy@ti.com>
 <1464006547-19569-4-git-send-email-j-keerthy@ti.com>
 <5743CC80.4070404@ti.com>
Message-ID: <5743D0FD.5070804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 24 May 2016 09:07 AM, Lokesh Vutla wrote:
>
>
> On Monday 23 May 2016 05:59 PM, Keerthy wrote:
>> keystone-k2l devices use pinmux and are compliant with PINCTRL_SINGLE.
>> Hence enable the config option.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>
> A similar patch[1] is already posted.
>
> [1]https://patchwork.kernel.org/patch/8958091/

Ah I had not seen them. If they are already reviewed and closer to be 
merged then Patch 2 and Patch 3 of this series can be dropped.

Regards,
Keerthy

>
> Thanks and regards,
> Lokesh
>
>> ---
>>   arch/arm/configs/keystone_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
>> index faba04d..71b42e6 100644
>> --- a/arch/arm/configs/keystone_defconfig
>> +++ b/arch/arm/configs/keystone_defconfig
>> @@ -144,6 +144,7 @@ CONFIG_I2C_DAVINCI=y
>>   CONFIG_SPI=y
>>   CONFIG_SPI_DAVINCI=y
>>   CONFIG_SPI_SPIDEV=y
>> +CONFIG_PINCTRL_SINGLE=y
>>   CONFIG_GPIOLIB=y
>>   CONFIG_GPIO_SYSFS=y
>>   CONFIG_GPIO_DAVINCI=y
>>
