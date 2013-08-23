From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 20:52:19 +0200
Subject: [PATCH] pinctrl: imx: Fix compilation with DEBUG enabled
In-Reply-To: <1377247137-19582-1-git-send-email-s.hauer@pengutronix.de>
References: <1377247137-19582-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CACRpkdbRKzG5Kh4hNcCkS+JcBm3dbD-WWEZpKcfDV9rMrxnqqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 10:38 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> This became broken with converting the pinmux arrays into struct
> types. While at it replace the preprocessor magic with a simple
> dev_dbg.
>
> Reported-by: Tushar Behera <tushar.behera@linaro.org>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Patch applied with Shawn's ACK.

Thanks!
Linus Walleij
