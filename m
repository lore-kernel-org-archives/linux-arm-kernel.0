From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Dec 2017 11:25:09 +0100
Subject: [PATCH 1/6] ARM: stm32: prepare stm32 family to welcome armv7
 architecture
In-Reply-To: <1512742277-28205-2-git-send-email-ludovic.Barre@st.com>
References: <1512742277-28205-1-git-send-email-ludovic.Barre@st.com>
 <1512742277-28205-2-git-send-email-ludovic.Barre@st.com>
Message-ID: <CACRpkdaKZk5N9F=_nYSzKWyXgW4xQ9Ltft7-UNM+a-nOpqq2xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 8, 2017 at 3:11 PM, Ludovic Barre <ludovic.Barre@st.com> wrote:

> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch prepares the STM32 machine for the integration of Cortex-A
> based microprocessor (MPU), on top of the existing Cortex-M
> microcontroller family (MCU). Since both MCUs and MPUs are sharing
> common hardware blocks we can keep using ARCH_STM32 flag for most of
> them. If a hardware block is specific to one family we can use either
> ARCH_STM32_MCU or ARCH_STM32_MPU flag.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

So yesterdays application processors are todays MCU processors.

I said this on a lecture for control systems a while back and
stated it as a reason I think RTOSes are not really seeing a bright
future compared to Linux.

It happened quicker than I thought though, interesting.

Yours,
Linus Walleij
