From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Aug 2013 22:34:42 +0200
Subject: [PATCH 2/5] pinctrl: imx: Catch no fsl,pins property
In-Reply-To: <1376050854-3303-3-git-send-email-s.hauer@pengutronix.de>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
 <1376050854-3303-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CACRpkda9brXNWXzPOGAuHotP0U+JUhP76=R_jKd9QPaWi6hKdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 9, 2013 at 2:20 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Instead of crashing the kernel print an error message when
> the fsl,pins property is missing.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Patch applied.

Yours,
Linus Walleij
