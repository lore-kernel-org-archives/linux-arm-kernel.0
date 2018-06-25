From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 25 Jun 2018 15:58:12 +0200
Subject: [PATCH 0/2] m_can support to stm32mp157c
In-Reply-To: <1526387039-14813-1-git-send-email-erwan.leray@st.com>
References: <1526387039-14813-1-git-send-email-erwan.leray@st.com>
Message-ID: <8c3a8c17-fac3-480c-1489-b20de4a9e042@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/15/2018 02:23 PM, Erwan Le Ray wrote:
> Add support for the Controller Area Network m_can to STM32MP157C SoC and
> activation on stm32mp157c-ev1 board
> 
> Bich Hemon (2):
>    ARM: dts: stm32: m_can support to stm32mp157c
>    ARM: dts: stm32: m_can activation on stm32mp157c-ev1
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 13 +++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts     |  6 ++++++
>   arch/arm/boot/dts/stm32mp157c.dtsi        | 26 ++++++++++++++++++++++++++
>   3 files changed, 45 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
