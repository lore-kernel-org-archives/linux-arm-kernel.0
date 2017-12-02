From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 2 Dec 2017 17:00:03 +0100
Subject: [PATCH v4 00/10] add pinmuxing support for pins in AXP209 and
 AXP813 PMICs
In-Reply-To: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
Message-ID: <CACRpkdaMxaLjsDETm6_56tyGDu6=W0L4SQCAA2mmSR4mkR-jAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 1, 2017 at 2:44 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:

> The AXP209 and AXP813 PMICs have several pins (respectively 3 and 2) that can
> be used either as GPIOs or for other purposes (ADC or LDO here).
>
> We already have a GPIO driver for the GPIO use of those pins on the AXP209.
> Let's "upgrade" this driver to support all the functions these pins can have.
>
> Then we add support to this driver for the AXP813 which is slighlty different
> (basically a different offset in two registers and one less pin).
>
> I suggest patches 1 to 8 go through Linus's tree and 9 and 10 via Maxime or
> Chen-Yu's tree.
>
> v4:

Looks overall good. As soon as Maxime is happy with everything I will
happily apply 1-8 to the pinctrl tree and then pull it to GPIO as well to
avoid clashes.

I think there were some minor comments but it seems almost finished.

Yours,
Linus Walleij
