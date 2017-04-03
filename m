From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 3 Apr 2017 16:55:43 +0200
Subject: [PATCH v5 0/5] usb: dwc2: Add support for USB OTG on STM32F4x9
In-Reply-To: <20170201012547.76158-1-bruherrera@gmail.com>
References: <20170201012547.76158-1-bruherrera@gmail.com>
Message-ID: <8bdaca46-c9d0-c9b8-be38-e0d89ea8dc35@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 02/01/2017 02:25 AM, Bruno Herrera wrote:
> The STM32F4x9 MCU family has two DWC2 USB OTG cores on it. One core is
> USB OTG FS and other core is USB OTG HS. The USB FS core only works with
> its internal phy whilst the USF HS core can work in HS with external ulpi
> phy or in FS/LS speed with the embedded FS PHY.
>
...
>
>  Documentation/devicetree/bindings/usb/dwc2.txt |  4 ++++
>  arch/arm/boot/dts/stm32f429-disco.dts          | 16 +++++++++++++
>  arch/arm/boot/dts/stm32f429.dtsi               | 31 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/stm32f469-disco.dts          | 16 +++++++++++++
>  drivers/usb/dwc2/core.h                        |  5 +++++
>  drivers/usb/dwc2/hcd.c                         | 15 ++++++++++++-
>  drivers/usb/dwc2/hw.h                          |  2 ++
>  drivers/usb/dwc2/params.c                      | 19 ++++++++++++++++
>  8 files changed, 107 insertions(+), 1 deletion(-)
>

Patches 2, 3, 4 & 5 (DT + bindings) applied on stm32-dt-for-v4.12

regards
Alex
