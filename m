From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 20 Mar 2014 04:19:21 -0700
Subject: [PATCH v6 00/36] mtd: st_spi_fsm: Add new driver
In-Reply-To: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
References: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140320111921.GR31517@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 09:20:32AM +0000, Lee Jones wrote:
> This should be the final version (again) :)
> 
> Version 6:
>   Serviced 3 nits picked up by Brian during final review.
>   
[...]
>  Documentation/devicetree/bindings/mtd/st-fsm.txt |   26 ++
>  arch/arm/boot/dts/stih416-pinctrl.dtsi           |   13 +
>  arch/arm/boot/dts/stih416.dtsi                   |   13 +
>  arch/arm/boot/dts/stih41x-b2020.dtsi             |    1 +
>  arch/arm/boot/dts/stih41x-b2020x.dtsi            |   28 ++
>  drivers/mtd/devices/Kconfig                      |    8 +
>  drivers/mtd/devices/Makefile                     |    1 +
>  drivers/mtd/devices/serial_flash_cmds.h          |   81 +++++
>  drivers/mtd/devices/st_spi_fsm.c                 | 2122 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 2293 insertions(+)

Pushed patches 1 to 35 to l2-mtd.git. Patch 36 should go via arm-soc, I
believe.

Thanks,
Brian
