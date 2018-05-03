From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 3 May 2018 17:12:32 +0200
Subject: [PATCH v1 0/3] Append additional I2C instances and activate I2C1.
In-Reply-To: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <6f1259a8-f036-d3bd-a17e-d1ceb77092f2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/20/2018 11:05 AM, Pierre-Yves MORDRET wrote:
> This patch intends to appends 3 additional I2C instances (2, 3 and 4).
> In the same time I2C1 is setup for both STM32F746 and STM32F769 Discovery
> boards.
> ---
>    Version history:
>       v1:
>          * Initial
> ---
> 
> Pierre-Yves MORDRET (3):
>    ARM: dts: stm32: Append additional I2Cs for STM32F746 SoC
>    ARM: dts: stm32: Add I2C1 support for STM32F769-DISCO Board
>    ARM: dts: stm32: Add I2C1 support for STM32F746-DISCO Board
> 
>   arch/arm/boot/dts/stm32f746-disco.dts |  8 ++++++++
>   arch/arm/boot/dts/stm32f746.dtsi      | 36 +++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32f769-disco.dts |  8 ++++++++
>   3 files changed, 52 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
