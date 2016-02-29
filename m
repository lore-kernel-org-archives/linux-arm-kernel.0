From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Mar 2016 00:32:48 +0100
Subject: [PATCH 1/1] arm64: defconfig: Enable Maxim PMIC max77620 config
In-Reply-To: <1456750972-13972-1-git-send-email-ldewangan@nvidia.com>
References: <1456750972-13972-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <3235756.j5eVi1g2v0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 18:32:52 Laxman Dewangan wrote:
> Enable following configs for the Maxim Semiconductor's PMIC
> MAX77620/MAX20024. This is used on NVIDIA's Tegra 210 platform
> Jetson-TX1.
> 
>  CONFIG_MFD_MAX77620 For MFD driver.
>  CONFIG_PINCTRL_MAX77620 For pin control support
>  CONFIG_GPIO_MAX77620 for GPIO Support.
>  CONFIG_REGULATOR_MAX77620 for regulator support.
>  CONFIG_RTC_DRV_MAX77686 for RTC support.
> 
> Enable Tegra I2C config to enable I2C in NVIDIA's Tegra 210
> platforms.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> The patches for drivers of MFD/GPIO/Pincontrol are in flight.
> 

I'm not entirely sure what you had meant to happen to this patch,
as you have a lot of people in the 'To' line.

Do you want us to pick it up into arm-soc with Thierry's Ack,
or should he forward it, or is there a reason for Catalin and
Will to put it into the arm64 tree?

	Arnd
