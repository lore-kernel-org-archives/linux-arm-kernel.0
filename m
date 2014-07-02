From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 02 Jul 2014 18:06:34 +0200
Subject: [PATCH v2 0/4] Add reset controllers for STiH407 SoC
In-Reply-To: <1404310129-14667-1-git-send-email-peter.griffin@linaro.org>
References: <1404310129-14667-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1404317194.4109.13.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Am Mittwoch, den 02.07.2014, 15:08 +0100 schrieb Peter Griffin:
> This series adds reset controller support for the STiH407 SoC.
> 
> Changes since v1
>  - Update copyright to 2014
>  - Add const qualifier
>  - Fix various whitespace issues
>  - Remove THIS_OWNER
>  - Move DT documentation into separate patch
> 
> Peter Griffin (4):
>   reset: stih407: Add softreset, powerdown and picophy controllers
>   reset: sti: Document sti-picophyreset controllers bindings.
>   ARM: sti: Add STiH407 Kconfig entry to select STIH407_RESET
>   ARM: sti: Add STiH407 reset controller support.
> 
>  .../bindings/reset/st,sti-picophyreset.txt         |  42 ++++++
>  arch/arm/boot/dts/stih407.dtsi                     |  16 +++
>  arch/arm/mach-sti/Kconfig                          |  10 ++
>  drivers/reset/sti/Kconfig                          |   4 +
>  drivers/reset/sti/Makefile                         |   1 +
>  drivers/reset/sti/reset-stih407.c                  | 158 +++++++++++++++++++++
>  .../dt-bindings/reset-controller/stih407-resets.h  |  61 ++++++++
>  7 files changed, 292 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
>  create mode 100644 drivers/reset/sti/reset-stih407.c
>  create mode 100644 include/dt-bindings/reset-controller/stih407-resets.h

Looks good to me now.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
