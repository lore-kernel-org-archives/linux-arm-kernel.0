From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Aug 2013 22:35:42 +0200
Subject: [PATCH 3/5] pinctrl: imx: do not fail when parsing a group fails
In-Reply-To: <1376050854-3303-4-git-send-email-s.hauer@pengutronix.de>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
 <1376050854-3303-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CACRpkdabnv78hGPxv3NofgtQBmcHRxrr1G0B7kgFxQWijCsAZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 9, 2013 at 2:20 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The i.MX pinctrl driver completely bails out when it detects an error
> in the pinctrl nodes. This usually means that whatever error a
> devicetree has the user is left blind because even the console cannot
> be initialized without working pinmux.
>
> Instead of bailing out completely, just continue probing. This makes
> the pinctrl driver work, only the erroneous groups will fail later
> during pin request time.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Patch applied.

Yours,
Linus Walleij
