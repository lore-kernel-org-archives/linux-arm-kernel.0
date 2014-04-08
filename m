From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Apr 2014 15:11:36 +0200
Subject: [PATCH v2] pinctrl: st: use gpiolib irqchip helpers
In-Reply-To: <1396961147-2754-1-git-send-email-maxime.coquelin@st.com>
References: <1396961147-2754-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <CACRpkdbMFaqtPh43sss-eZbY7gFVQHg_+WH7TsJ04KkZvNJg5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 8, 2014 at 2:45 PM, Maxime COQUELIN <maxime.coquelin@st.com> wrote:

> The v1 was sent by Linus (https://lkml.org/lkml/2014/4/4/287).
> Two changes were necessary to make it to work properly on STiH416:
>   1 - dev reference was not passed to the gpio_chip struct, causing a panic
>   2 - gpiochip_irqchip_add passed IRQ_TYPE_NONE as default type, which caused
> lot of warnings at init time. I choose IRQ_TYPE_LEVEL_LOW as default.

Thanks a lot for fixing this Maxime, this version of the patch
applied!

Yours,
Linus Walleij
