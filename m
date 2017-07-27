From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 27 Jul 2017 09:28:39 +0200
Subject: [PATCH 0/2] Enable ADC support on STM32H7
In-Reply-To: <1499789590-13021-1-git-send-email-fabrice.gasnier@st.com>
References: <1499789590-13021-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <d3ac7f0c-4164-769c-8f78-0bde425774bf@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice,

On 07/11/2017 06:13 PM, Fabrice Gasnier wrote:
> This patchset adds ADC device-tree nodes to STM32H7 SoC and
> enables ADC1 by default on stm32h743i-eval board.
> 
> Fabrice Gasnier (2):
>    ARM: dts: stm32: add ADC support on stm32h7
>    ARM: dts: stm32: enable ADC on stm32h743i-eval board
> 
>   arch/arm/boot/dts/stm32h743.dtsi      | 53 +++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32h743i-eval.dts | 18 ++++++++++++
>   2 files changed, 71 insertions(+)
> 
Series applied on stm32-dt-for-v4.14 branch.

Thanks
Alex
