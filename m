From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 18:02:29 +0100
Subject: [PATCH] pinctrl: freescale: add ZERO_OFFSET_VALID flag for vf610
 pinctrl
In-Reply-To: <1448437251-21487-1-git-send-email-shawnguo@kernel.org>
References: <1448437251-21487-1-git-send-email-shawnguo@kernel.org>
Message-ID: <CACRpkdZCakhg57S5rSNnzyUzx1zvHnAy_edx6RjDfpDvvBKw4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 8:40 AM, Shawn Guo <shawnguo@kernel.org> wrote:

> To support i.MX7D Low Power State Retention IOMUXC, commit e7b37a522aa9
> ("pinctrl: freescale: imx: allow mux_reg offset zero") changes the way
> of zero mux_reg offset support with a new flag ZERO_OFFSET_VALID.  But,
> unfortunately, it forgot to add this flag for vf610 pinctrl which has
> zero mux_reg offset be valid as well, and hence breaks the vf610
> support.
>
> Fix the regression by adding flag ZERO_OFFSET_VALID for vf610 pinctrl
> driver.
>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> Fixes: e7b37a522aa9 ("pinctrl: freescale: imx: allow mux_reg offset zero")
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Stefan Agner <stefan@agner.ch>

Patch applied for fixes.

Sorry for the delay.

Yours,
Linus Walleij
