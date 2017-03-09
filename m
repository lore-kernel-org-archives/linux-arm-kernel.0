From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 9 Mar 2017 10:14:07 +0100
Subject: [PATCH 0/3] Add RTC support on STM32F746
In-Reply-To: <1484833519-9298-1-git-send-email-amelie.delaunay@st.com>
References: <1484833519-9298-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <92beeacd-5d2e-7c4c-7070-56885ebeeca4@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie,

On 01/19/2017 02:45 PM, Amelie Delaunay wrote:
> This patchset enables STM32 RTC on STM32F746 MCU.
>
> Amelie Delaunay (3):
>   ARM: dts: stm32: set HSE_RTC clock frequency to 1 MHz on stm32f746
>   ARM: dts: stm32: Add RTC support for STM32F746 MCU
>   ARM: dts: stm32: enable RTC on stm32746g-eval
>

Can you please rebase this series on 4.11-rc1 and resend ?

Thanks in advance


>  arch/arm/boot/dts/stm32746g-eval.dts |  4 ++++
>  arch/arm/boot/dts/stm32f746.dtsi     | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
>
