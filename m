From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Fri, 2 Jun 2017 09:29:14 +0200
Subject: [PATCH v4 0/6] ARM: at91: initial samx7 support
In-Reply-To: <20170601200601.11035-1-alexandre.belloni@free-electrons.com>
References: <20170601200601.11035-1-alexandre.belloni@free-electrons.com>
Message-ID: <19e8c642-50c8-85c3-7edc-52218a83288f@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/06/2017 ? 22:05, Alexandre Belloni a ?crit :
> This series adds initial support for Atmel armv7m SoCs.

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
To the whole series.

Thanks Szemz? and Alexandre for having taken care of this support!

Best regards,

> Changes in v4:
>  - rename the family samv7 as the internal name is samv7x and it may conflict
>    with future SoCs.
> 
> Changes in v3:
>  - dropped most of the changes in Atmel/README
>  - rebased on v4.12-rc1
>  - removed the dtsi until the tcb series is taken
> 
> Changes in v2:
>  - fixed checkpatch issues
>  - Added documentation
>  - removed Ethernet from the dtsi until the driver change is taken
> 
> 
> Alexandre Belloni (3):
>   ARM: at91: Documentation: add armv7m families
>   ARM: at91: Document armv7m compatibles
>   ARM: at91: handle CONFIG_PM for armv7m configurations
> 
> Szemz? Andr?s (3):
>   ARM: at91: Add armv7m support
>   ARM: at91: add armv7m SoC detection
>   ARM: at91: debug: add samv7x support
> 
>  Documentation/arm/Atmel/README                     | 38 +++++++++++++++++++++-
>  .../devicetree/bindings/arm/atmel-at91.txt         | 30 +++++++++++++++++
>  arch/arm/Kconfig.debug                             | 10 ++++++
>  arch/arm/mach-at91/Kconfig                         | 16 ++++++++-
>  arch/arm/mach-at91/Makefile                        |  4 +--
>  arch/arm/mach-at91/Makefile.boot                   |  3 ++
>  arch/arm/mach-at91/samv7.c                         | 34 +++++++++++++++++++
>  drivers/soc/atmel/soc.c                            | 24 ++++++++++++++
>  drivers/soc/atmel/soc.h                            | 26 +++++++++++++++
>  9 files changed, 181 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/mach-at91/Makefile.boot
>  create mode 100644 arch/arm/mach-at91/samv7.c
> 


-- 
Nicolas Ferre
