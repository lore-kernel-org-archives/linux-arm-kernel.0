From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Sep 2014 10:27:22 +0200
Subject: [PATCH v2 1/3] pinctrl: at91: add drive strength configuration
In-Reply-To: <1408849926-9603-1-git-send-email-mark.roszko@gmail.com>
References: <1408849926-9603-1-git-send-email-mark.roszko@gmail.com>
Message-ID: <CACRpkdazv59T6xOSAxJQ7t5KDb7wyG4HwFTM+q4KC67ZFrZ26g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 24, 2014 at 5:12 AM, Marek Roszko <mark.roszko@gmail.com> wrote:

> The SAMA5 and SAM9x5 series both have drive strength options for the PIOs. This
> patch adds the ability to set one of three hardware options for drive strengths of low,
> medium or high for the each pin. The actual current output of the chip based on the setting
> is defined in the datasheets and varies per pins separate from banks and with supply voltage.
>
> This patch adds three new dt-bindings that allow setting the strength when configuring
> pins. By default, no change will be made to the drive strength of a pin from its reset value.
> Due to the difference between the register addresses of the SAMA5 and SAM9x5 series, a new
> sama5d3-pinctrl id was added.
>
> Signed-off-by: Marek Roszko <mark.roszko@gmail.com>

Waiting for feedback from AT91 maintainers...

Yours,
Linus Walleij
