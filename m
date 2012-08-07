From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Aug 2012 14:27:48 +0200
Subject: [PATCH 1/2] pinctrl: use ERR_CAST instead of ERR_PTR(PTR_ERR(...))
In-Reply-To: <1343666314-18070-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343666314-18070-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkda5SO7fVtihxCnSTA39uCcJaFC-o9fZ8x9ExhmSoN6eQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 6:38 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> This doesn't change semantics, just looks nicer.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied for v3.7.

Thanks,
Linus Walleij
