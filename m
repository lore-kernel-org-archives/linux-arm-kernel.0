From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 3 May 2018 16:58:00 +0200
Subject: [PATCH 0/3] ARM: dts: stm32: Add display support on
 stm32f469-disco
In-Reply-To: <20180215082014.30383-1-philippe.cornu@st.com>
References: <20180215082014.30383-1-philippe.cornu@st.com>
Message-ID: <0b6b2bac-a9b5-2e08-5da6-e367a083b03d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe

On 02/15/2018 09:20 AM, Philippe Cornu wrote:
> This serie adds the mipi dsi support to stm32f469 and enables it
> on the stm32f469-disco board.
> 
> Philippe CORNU (1):
>    ARM: dts: stm32: Add display support on stm32f469-disco
> 
> Philippe Cornu (2):
>    ARM: dts: stm32: Add dt-bindings gpio.h include on stm32f469-disco
>    ARM: dts: stm32: Add new stm32f469 dtsi file with mipi dsi
> 
>   arch/arm/boot/dts/stm32f469-disco.dts | 54 +++++++++++++++++++++++++++++++++--
>   arch/arm/boot/dts/stm32f469.dtsi      | 19 ++++++++++++
>   2 files changed, 71 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/boot/dts/stm32f469.dtsi
> 

Thanks for new dtsi file. Series applied on stm32-next.

Regards
Alex
