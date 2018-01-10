From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jan 2018 14:22:18 +0100
Subject: [PATCH 1/3] gpiolib: Export gpiochip_irqchip_irq_valid() to
 drivers
In-Reply-To: <20180110015848.11480-2-sboyd@codeaurora.org>
References: <20180110015848.11480-1-sboyd@codeaurora.org>
 <20180110015848.11480-2-sboyd@codeaurora.org>
Message-ID: <CACRpkdbW0cKwfzwVu4dz3pe2qvdT=Pkr6Lxq0FW12S0NfcHd6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 2:58 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> Some pinctrl drivers can use the gpiochip irq valid information
> to figure out if certain gpios are exposed to the kernel for
> usage or not. Expose this API so we can use it in the
> pinmux_ops::request ops.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Makes a lot of sense.

Patch applied with Bj?rn's ACK.

Yours,
Linus Walleij
