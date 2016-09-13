From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Sep 2016 10:14:16 +0200
Subject: [PATCH v5 6/9] pinctrl: Add IRQ support to STM32 gpios
In-Reply-To: <1473432124-6784-7-git-send-email-alexandre.torgue@st.com>
References: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
 <1473432124-6784-7-git-send-email-alexandre.torgue@st.com>
Message-ID: <CACRpkdb_uDyDSfv=61+Dwa=HDbDqc9iNKEcOOp36VwGzUPV44Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2016 at 4:42 PM, Alexandre TORGUE
<alexandre.torgue@st.com> wrote:

> This patch adds IRQ support to STM32 gpios.
>
> The EXTI controller has 16 lines dedicated to GPIOs.
> EXTI line n can be connected to only line n of one of the GPIO ports, for
> example EXTI0 can be connected to either PA0, or PB0, or PC0...
> This port selection is done by specifying the port number into System
> Config registers.
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Nicely isolated from the other irq stuff and abstracted.

It's complex but this is as clean as we can make it,
thanks for your efforts.

Patch applied.

Yours,
Linus Walleij
