From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Dec 2011 18:01:12 +0100
Subject: [RFC PATCH 2/3] pinctrl: imx: add pinmux-imx53 support
In-Reply-To: <20111204161123.GS27267@pengutronix.de>
References: <1322999384-7886-1-git-send-email-b29396@freescale.com>
 <1322999384-7886-2-git-send-email-b29396@freescale.com>
 <20111204161123.GS27267@pengutronix.de>
Message-ID: <CACRpkdZ0aNj-BsdtD2R-bEWQfMzsOMNbdh6ryVtgwET3Ry7xXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 4, 2011 at 5:11 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> I don't think that this grouping of pads to their functions makes
> sense. On i.MX every pad is muxed independently and not in groups.
> Which pins belong to which function is board specific and not SoC
> specific.

True, Dong can this be moved to the imx pinctrl platform data
and passed in from arch/arm/[plat|mach]-* board files instead?
That is probably where it belongs today.

I know that this data is in drivers/pinctrl for the U300 and SIRF,
but that is because they only have one single board variant.

Yours,
Linus Walleij
