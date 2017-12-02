From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 2 Dec 2017 16:57:56 +0100
Subject: [PATCH v4 08/10] mfd: axp20x: add pinctrl cell for AXP813
In-Reply-To: <e0b4ce746c052b78f08dff54d0ad7ce7ebc611ab.1512135804.git-series.quentin.schulz@free-electrons.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
 <e0b4ce746c052b78f08dff54d0ad7ce7ebc611ab.1512135804.git-series.quentin.schulz@free-electrons.com>
Message-ID: <CACRpkdZJ3gDqnLVW0NZMJiF7qRJSu-0Usys0tKfT-aep4bRxjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 1, 2017 at 2:44 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:

> As GPIO/pinctrl driver now supports AXP813, add a cell for it.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

It doesn't seem to have any dependencies so I guess Lee can simply
apply this separately.

Yours,
Linus Walleij
