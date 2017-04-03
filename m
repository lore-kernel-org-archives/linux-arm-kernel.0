From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 3 Apr 2017 16:51:14 +0200
Subject: [PATCH 0/3] Add RTC support on STM32F746
In-Reply-To: <1484833519-9298-1-git-send-email-amelie.delaunay@st.com>
References: <1484833519-9298-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <9deef7aa-e060-61bb-1680-c9b728f85a81@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 01/19/2017 02:45 PM, Amelie Delaunay wrote:
> This patchset enables STM32 RTC on STM32F746 MCU.
>
> Amelie Delaunay (3):
>   ARM: dts: stm32: set HSE_RTC clock frequency to 1 MHz on stm32f746
>   ARM: dts: stm32: Add RTC support for STM32F746 MCU
>   ARM: dts: stm32: enable RTC on stm32746g-eval
>
>  arch/arm/boot/dts/stm32746g-eval.dts |  4 ++++
>  arch/arm/boot/dts/stm32f746.dtsi     | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
>

Series applied on stm32-dt-for-v4.12

regards
Alex
