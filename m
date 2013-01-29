From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Jan 2013 23:38:17 +0100
Subject: [PATCHv4] ARM: sunxi: gpio: Add Allwinner SoCs GPIO drivers
In-Reply-To: <1359405192-1192-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1359405192-1192-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdaNz6szEu6v=C97MfUzQzM3rG1hGHtHdO-aWXLCgHQEeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 9:33 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The IP responsible for the muxing on the Allwinner SoCs are also
> handling the GPIOs on the system. This patch adds the needed driver that
> relies on the pinctrl driver for most of its operations.
>
> The number of pins available for GPIOs operations are already declared
> in the pinctrl driver, we only need to probe a generic driver to handle
> the banks available for each SoC.
>
> This driver has been tested on a A13-Olinuxino.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied to my allwinner branch.

I'm a bit confused with other patches floating around,
I hope I'm supposed to apply this first...

Thanks,
Linus Walleij
