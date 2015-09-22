From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Sep 2015 17:57:46 -0700
Subject: [PATCH v3 4/9] gpio-sysfs: Use gpio descriptor name instead of
 gpiochip names array
In-Reply-To: <1439561466-14350-5-git-send-email-mpa@pengutronix.de>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
 <1439561466-14350-5-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdabejwA3jeP6yCUp4vQw1hLryJMgdExsvz1d1Sz4vFkDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 7:11 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> The name is now stored in the gpio descriptor as well, for example to
> allow to store names from DT. This patch changes the sysfs gpio files
> to use the gpio descriptor name.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Patch applied. This is a very nice patch too.

Yours,
Linus Walleij
