From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Mar 2016 11:03:55 +0100
Subject: [PATCH 2/4] mfd: axp20x: Add AXP209 GPIO driver to the mfd
In-Reply-To: <1457520614-32239-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
 <1457520614-32239-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdY4p6n-B58TUdaqkcDP0s0aAf8OCR08F3prA00C5M3Nyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 9, 2016 at 11:50 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Now that we have a GPIO driver for the AXP209, we can add it to our MFD.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
(...)
> +               .name           = "axp20x-gpio",
> +               .of_compatible  = "x-powers,axp209-gpio",

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Professor X must be behind this X-powers X men.

Yours,
Linus Walleij
