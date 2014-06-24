From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Jun 2014 10:23:09 +0100
Subject: [RESEND PATCH 0/6] thermal: sti: Add new Thermal driver
In-Reply-To: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
References: <1401980819-19962-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140624092309.GD13803@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm re-sending this set, as one of the maintainers' email addresses
> is incorrect in the MAINTAINERS file.
> 
> This patchset adds full support for 2 types of Thermal Controllers
> produced by STMicroelectronics.  One is a more traditional memory
> mapped variant, the other is controlled solely by system configuration
> registers.

Any thing from the Thermal guys? Has this set fallen through the gaps?

>  Documentation/devicetree/bindings/thermal/st-thermal.txt |  42 ++++++++++++++++
>  arch/arm/boot/dts/stih416.dtsi                           |  18 +++++++
>  arch/arm/configs/multi_v7_defconfig                      |   2 +
>  drivers/thermal/Kconfig                                  |   5 ++
>  drivers/thermal/Makefile                                 |   1 +
>  drivers/thermal/st/Kconfig                               |  12 +++++
>  drivers/thermal/st/Makefile                              |   3 ++
>  drivers/thermal/st/st_thermal.c                          | 313 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> ++++++++++++++++++++++++++++
>  drivers/thermal/st/st_thermal.h                          | 104 ++++++++++++++++++++++++++++++++++++++
>  drivers/thermal/st/st_thermal_memmap.c                   | 209 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/thermal/st/st_thermal_syscfg.c                   | 179 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  11 files changed, 888 insertions(+)
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
