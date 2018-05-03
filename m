From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 3 May 2018 15:06:28 +0200
Subject: [PATCH 0/2] ARM: dts: stm32: add qspi support for stm32mp157c
In-Reply-To: <1525072281-17472-1-git-send-email-ludovic.Barre@st.com>
References: <1525072281-17472-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <e6ab9571-c227-9246-3b34-f28420f0dbd5@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

On 04/30/2018 09:11 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series adds qspi support for stm32mp157c SoC
> and its eval board.
> 
> Ludovic Barre (2):
>    ARM: dts: stm32: add qspi support for stm32mp157c
>    ARM: dts: stm32: add flash nor support on stm32mp157c eval board
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 45 +++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts     | 25 +++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c.dtsi        | 11 ++++++++
>   3 files changed, 81 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
