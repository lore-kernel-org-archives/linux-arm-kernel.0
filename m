From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 29 Jul 2018 22:11:36 +0200
Subject: [PATCH 2/2] pinctrl: stm32: check node status before new gpio
 bank registering
In-Reply-To: <1531745857-5561-3-git-send-email-alexandre.torgue@st.com>
References: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
 <1531745857-5561-3-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdaDy5MGPMxh3GYFHL9VqTv44=t6J=xu_0sdXc4OHFo84g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 2:57 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> Register a new GPIO bank only if GPIO bank node is enabled. This patch also
> adds checks on ranges which are defined only if a bank is registered.
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

Patch applied.

Alexandre can you check the discussion we've had about using
GPIOLIB_IRQCHIP for multi-bank GPIOs with several IRQ
lines as per drivers/gpio/gpio-tegra186.c?

Is this approach applicable for STM32 so we can pull
more stuff in under GPIOLIB_IRQCHIP?

Yours,
Linus Walleij
