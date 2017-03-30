From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Mar 2017 17:36:17 +0200
Subject: [PATCH] ARM: configs: stm32: Set CPU_V7M_NUM_IRQ to max value
In-Reply-To: <1490263746-10512-1-git-send-email-alexandre.torgue@st.com>
References: <1490263746-10512-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <CAK8P3a3VYRUvFKd1CMTE-T-FhTx1YJr18Hqatmz7YK+A+JtFeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 11:09 AM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:
> stm32_defconfig is used for several STM32 MCU: STM32F429, STM32F469,
> STM32F746 and now STM32H743. Each of MCU listed have different interrupts
> number mapped on NVIC. STM32F429: 81, STM32F469: 92, STM32F746: 97 and
> STM32H743: 149. I could set CPU_V7M_NUM_IRQ to 149 but in order to avoid
> forgetting to update this value for next STM32 MCU I prefer to set it to
> max value: 240.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

It's not entirely clear who you want to apply this (if any), given that you sent
the patch to yourself. I've applied it to next/defconfig now, hope that's
what you intended.

      Arnd
