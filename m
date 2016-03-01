From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 1 Mar 2016 17:07:23 +0530
Subject: [PATCH 1/1] arm64: defconfig: Enable Maxim PMIC max77620 config
In-Reply-To: <3235756.j5eVi1g2v0@wuerfel>
References: <1456750972-13972-1-git-send-email-ldewangan@nvidia.com>
 <3235756.j5eVi1g2v0@wuerfel>
Message-ID: <56D57EF3.6060805@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tuesday 01 March 2016 05:02 AM, Arnd Bergmann wrote:
> On Monday 29 February 2016 18:32:52 Laxman Dewangan wrote:
>> Enable following configs for the Maxim Semiconductor's PMIC
>> MAX77620/MAX20024. This is used on NVIDIA's Tegra 210 platform
>> Jetson-TX1.
>>
>>   CONFIG_MFD_MAX77620 For MFD driver.
>>   CONFIG_PINCTRL_MAX77620 For pin control support
>>   CONFIG_GPIO_MAX77620 for GPIO Support.
>>   CONFIG_REGULATOR_MAX77620 for regulator support.
>>   CONFIG_RTC_DRV_MAX77686 for RTC support.
>>
>> Enable Tegra I2C config to enable I2C in NVIDIA's Tegra 210
>> platforms.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> ---
>> The patches for drivers of MFD/GPIO/Pincontrol are in flight.
>>
> I'm not entirely sure what you had meant to happen to this patch,
> as you have a lot of people in the 'To' line.
>
> Do you want us to pick it up into arm-soc with Thierry's Ack,
> or should he forward it, or is there a reason for Catalin and
> Will to put it into the arm64 tree?
>
>

Not sure how will it go (via Tegra or arm-soc) but I will need Thierry's 
or Rhyland Klein's ACK.
