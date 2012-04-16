From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Apr 2012 18:09:46 +0200
Subject: [PATCH v2 0/3] Add support for Atmel's AT91SAM9N12-EK (With DT)
In-Reply-To: <1334569167-7064-1-git-send-email-hong.xu@atmel.com>
References: <1334569167-7064-1-git-send-email-hong.xu@atmel.com>
Message-ID: <4F8C444A.8030705@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2012 11:39 AM, Hong Xu :
> This series adds support for Atmel's AT91SAM9N12-EK.
> 
> Patches are on top of v3.4-rc2 and target for v3.5

Comments on the v2 following ;-)

> 
> Hong Xu (3):
>   AT91: Add DT description files for AT91SAM9N12-EK
>   AT91: Add machine header file for AT91SAM9N12 SoC
>   AT91: Add machine files for AT91SAM9N12 SoC
> 
>  arch/arm/boot/dts/at91sam9n12.dtsi                 |  223 ++++++++++++++++
>  arch/arm/boot/dts/at91sam9n12ek.dts                |   99 +++++++
>  arch/arm/mach-at91/Kconfig                         |    9 +
>  arch/arm/mach-at91/Makefile                        |    1 +
>  arch/arm/mach-at91/Makefile.boot                   |    2 +
>  arch/arm/mach-at91/at91sam9n12.c                   |  275 ++++++++++++++++++++
>  arch/arm/mach-at91/clock.c                         |   15 +-
>  arch/arm/mach-at91/include/mach/at91sam9n12.h      |   60 +++++
>  .../mach-at91/include/mach/at91sam9n12_matrix.h    |   53 ++++
>  arch/arm/mach-at91/include/mach/cpu.h              |   10 +
>  arch/arm/mach-at91/include/mach/hardware.h         |    2 +
>  arch/arm/mach-at91/setup.c                         |    6 +
>  arch/arm/mach-at91/soc.h                           |    5 +
>  13 files changed, 755 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/boot/dts/at91sam9n12.dtsi
>  create mode 100644 arch/arm/boot/dts/at91sam9n12ek.dts
>  create mode 100644 arch/arm/mach-at91/at91sam9n12.c
>  create mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12.h
>  create mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12_matrix.h
> 


-- 
Nicolas Ferre
