From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Aug 2012 15:57:49 +0200
Subject: [PATCH] pinctrl: pinctrl-imx: add imx35 pinctrl driver
In-Reply-To: <1344529412-18053-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1344529412-18053-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdZGG8ZysHe=JAdoyrfaome+cFDNLkco3uukQVOThbf8Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 6:23 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> This is mostly cut'n'paste from the imx51 pinctrl driver. The data was
> generated using sed and awk on
> arch/arm/plat-mxc/include/mach/iomux-mx35.h.

OK, applied this version with the small doc fixup requested by Uwe, and
added Shawn's ACK too.

Yours,
Linus Walleij
