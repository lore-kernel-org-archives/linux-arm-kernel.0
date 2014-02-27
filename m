From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Feb 2014 10:16:43 +0100
Subject: [PATCH] gpio: only enable kona driver on BCM_MOBILE or for
 compile testing
In-Reply-To: <1392990146-18916-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1392990146-18916-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdZg5uoP5LurL5vOPCaKQu2B=neybuo=gwM_JT7UAhRkjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 2:42 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> This change makes it easier to configure a kernel for a real machine by
> not showing the option to enable it at all if COMPILE_TEST is off.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Markus: can you ACK this patch?

Yours,
Linus Walleij
