From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 23 Jan 2015 15:20:45 +0100
Subject: [PATCH v5 0/2] ARM: mediatek: Add watchdog driver
In-Reply-To: <1421152136-5007-1-git-send-email-matthias.bgg@gmail.com>
References: <1421152136-5007-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <CABuKBeKWU=wGuyT2u1Ndori1e8B7vAzFAmCafwLDPfAyLHkYBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

2015-01-13 13:28 GMT+01:00 Matthias Brugger <matthias.bgg@gmail.com>:
> Mediatek SoCs have a watchdog driver. This patch set adds driver and DTS
> binding. The driver also implements a restart handler to reboot the SoC.

Any comments on this patch set?

>
> Changes for v5:
> - add newline in dev_info message
> - add tested-by and reviewed-by
>
> Changes for v4:
> - fix indentation errors
> - delete unused include
> - reorganize while loop to eliminate code duplication
> - eliminate indirection to watchdog_device structure
> - delete unnecessary brackets
>
> Changes for v3:
> - fix based on file name
> - fix style problems
> - fix error return value and warning message
> - delete unnecessary watchdog_set_drvdata
> - delete unused variable
>
> Changes for v2:
> - we don't need to have the watchdog enabled to do a software reset
> - disable dual mode and irq mode when starting the watchdog
> - update commit message to name the SoCs the driver supports
>
>
> Matthias Brugger (2):
>   watchdog: Add driver for Mediatek watchdog
>   ARM: mediatek: dts: Add bindings for watchdog
>
>  .../devicetree/bindings/watchdog/mtk-wdt.txt       |  13 ++
>  drivers/watchdog/Kconfig                           |  10 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/mtk_wdt.c                         | 252 +++++++++++++++++++++
>  4 files changed, 276 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>  create mode 100644 drivers/watchdog/mtk_wdt.c
>
> --
> 1.9.1
>



-- 
motzblog.wordpress.com
