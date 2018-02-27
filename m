From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 27 Feb 2018 16:57:12 +0100
Subject: [PATCH 0/3] USB OTG on STM32F7 boards
In-Reply-To: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
References: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <06730939-11f4-c8da-02a8-7bab37f194ce@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie

On 02/15/2018 04:54 PM, Amelie Delaunay wrote:
> This patchset adds support for Peripheral mode on stm32f746 by adding
> dwc2 gadget fifo sizes and enables USB OTG HS in OTG (DRD) mode on
> stm32746g-eval and stm32f769-disco. It possible to use OTG HS in
> Peripheral or Host mode, depending on the USB connector.
> 
> Amelie Delaunay (3):
>    ARM: dts: stm32: add gadget fifo sizes to usbotg_hs on stm32f746
>    ARM: dts: stm32: select otg mode for usbotg_hs on stm32746g_eval
>    ARM: dts: stm32: enable USB HS on stm32f769-disco
> 
>   arch/arm/boot/dts/stm32746g-eval.dts  |  2 +-
>   arch/arm/boot/dts/stm32f746.dtsi      |  3 +++
>   arch/arm/boot/dts/stm32f769-disco.dts | 15 +++++++++++++++
>   3 files changed, 19 insertions(+), 1 deletion(-)
> 

Series applied on stm32-next.

Regards
Alex
