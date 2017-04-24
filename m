From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 14:30:37 +0200
Subject: [PATCH v2 6/7] ARM: Kconfig: Introduce MACH_STM32F469 flag
In-Reply-To: <1491568984-20169-7-git-send-email-alexandre.torgue@st.com>
References: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
 <1491568984-20169-7-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdZmWFKaZWB8qZaH=jB61xdwvJ=TC8idYH9kJdi=HEZRAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 7, 2017 at 2:43 PM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> This patch introduces the MACH_STM32F469 to make possible to only select
> STM32F469 pinctrl driver
>
> By default, all the MACH_STM32Fxxx flags will be set with STM32 defconfig.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this through the ARM SoC tree.

Yours,
Linus Walleij
