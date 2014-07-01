From: rui.zhang@intel.com (Zhang Rui)
Date: Tue, 01 Jul 2014 10:07:03 +0800
Subject: [PATCH 0/6] thermal: sti: Add new Thermal driver
In-Reply-To: <1401442715-6350-1-git-send-email-lee.jones@linaro.org>
References: <1401442715-6350-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1404180423.8366.15.camel@rzhang1-toshiba>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Eduardo,

what do you think of this patch set?

thanks,
rui

On Fri, 2014-05-30 at 10:38 +0100, Lee Jones wrote:
> This patchset adds full support for 2 types of Thermal Controllers
> produced by STMicroelectronics.  One is a more traditional memory
> mapped variant, the other is controlled solely by system configuration
> registers.
> 
>  Documentation/devicetree/bindings/thermal/st-thermal.txt |  42 ++++++++++++++++
>  arch/arm/boot/dts/stih416.dtsi                           |  18 +++++++
>  arch/arm/configs/multi_v7_defconfig                      |   2 +
>  drivers/thermal/Kconfig                                  |   5 ++
>  drivers/thermal/Makefile                                 |   1 +
>  drivers/thermal/st/Kconfig                               |  12 +++++
>  drivers/thermal/st/Makefile                              |   3 ++
>  drivers/thermal/st/st_thermal.c                          | 313 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/thermal/st/st_thermal.h                          | 104 ++++++++++++++++++++++++++++++++++++++
>  drivers/thermal/st/st_thermal_memmap.c                   | 209 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/thermal/st/st_thermal_syscfg.c                   | 179 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  11 files changed, 888 insertions(+)
> 
