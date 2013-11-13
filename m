From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 13 Nov 2013 18:49:20 +0100
Subject: [PATCH v3 0/2] ARM: at91: sama5d3: add sama5d36ek support
In-Reply-To: <1383732072-24938-1-git-send-email-josh.wu@atmel.com>
References: <1383732072-24938-1-git-send-email-josh.wu@atmel.com>
Message-ID: <5283BBA0.8000106@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2013 11:01, Josh Wu :
> This patch series add support for sama5d36 in sama5d3x family.
> It also adds the dts & dtsi file for sama5d36ek board.
>
> v2 --> v3:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I'll integrate them in at91-3.14-dt branch.

Thank, best regards,


>    change the copyright.
>
> v1 --> v2:
>    base on the at91-3.13-cleanup tree.
>    add a new sama5d36.dtsi to include the splitted peripherals.
>
> Josh Wu (2):
>    ARM: at91: sama5d3: add support for sama5d36 chip
>    ARM: at91: sama5d3/dt: add sama5d36ek dts files
>
>   arch/arm/boot/dts/Makefile            |    1 +
>   arch/arm/boot/dts/sama5d3.dtsi        |    2 +-
>   arch/arm/boot/dts/sama5d36.dtsi       |   20 +++++++++++++
>   arch/arm/boot/dts/sama5d36ek.dts      |   53 +++++++++++++++++++++++++++++++++
>   arch/arm/mach-at91/Kconfig            |    2 +-
>   arch/arm/mach-at91/include/mach/cpu.h |    3 +-
>   arch/arm/mach-at91/sama5d3.c          |    7 ++---
>   arch/arm/mach-at91/setup.c            |    4 +++
>   8 files changed, 85 insertions(+), 7 deletions(-)
>   create mode 100644 arch/arm/boot/dts/sama5d36.dtsi
>   create mode 100644 arch/arm/boot/dts/sama5d36ek.dts
>


-- 
Nicolas Ferre
