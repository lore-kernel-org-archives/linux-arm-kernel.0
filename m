From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 2 May 2018 10:13:30 +0200
Subject: [PATCH 0/4] Add STM32 timers to stm32mp157c
In-Reply-To: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
References: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <4173223f-3790-2f53-8ed7-3d7fdecc0e76@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice,

On 04/17/2018 03:45 PM, Fabrice Gasnier wrote:
> This series adds support for STM32 timers to stm32mp157c. These
> timers can act PWM, trigger and/or encoder.
> Populate stm32mp157c SOC and ed1/ev1 boards.
> 
> Fabrice Gasnier (4):
>    ARM: dts: stm32: add timers support to stm32mp157c
>    ARM: dts: stm32: add PWM pins used on stm32mp157c-ev1 board
>    ARM: dts: stm32: add PWM and triggers on stm32mp157c-ev1 board
>    ARM: dts: stm32: enable timer trigger 6 on stm32mp157c-ed1
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi |  27 +++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts     |   7 +
>   arch/arm/boot/dts/stm32mp157c-ev1.dts     |  36 ++++
>   arch/arm/boot/dts/stm32mp157c.dtsi        | 283 ++++++++++++++++++++++++++++++
>   4 files changed, 353 insertions(+)
> 

Series applied on stm32-next.
Note that I modified pinctrl patch to fix DTC warnings when make W=12 is 
used.

Regards
Alex
