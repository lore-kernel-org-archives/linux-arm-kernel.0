From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 7 Jun 2017 09:04:56 +0200
Subject: [PATCH 0/3] Add stm32h743i-disco board
In-Reply-To: <1496765613-697-1-git-send-email-patrice.chotard@st.com>
References: <1496765613-697-1-git-send-email-patrice.chotard@st.com>
Message-ID: <f8d09cbf-8535-5906-28ee-6d9774a49c44@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrice

On 06/06/2017 06:13 PM, patrice.chotard at st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> This series adds basic support for the stm32h743i discovery board
> based on stm32h7 MCU.
>
> Patrice Chotard (3):
>   ARM: dts: stm32h743: Add usart2_pins
>   ARM: dts: stm32h743: Add usart2 support
>   ARM: dts: stm32h743: Add stm32h743i-disco board
>
>  arch/arm/boot/dts/Makefile               |  3 +-
>  arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 13 ++++++
>  arch/arm/boot/dts/stm32h743.dtsi         |  8 ++++
>  arch/arm/boot/dts/stm32h743i-disco.dts   | 74 ++++++++++++++++++++++++++++++++
>  4 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/stm32h743i-disco.dts
>

Series looks fine for me, but can you change commit header please. For 
example: ARM: dts: stm32: Add usart2_pins on stm32h743.

Soon it will be done, I will apply it for next pull request.

Regards
Alex
