From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Sep 2015 18:07:51 -0700
Subject: [PATCH v3 6/9] gpiolib-sysfs: Show gpio-name in
 /sys/class/gpio/gpio*/name
In-Reply-To: <1439561466-14350-7-git-send-email-mpa@pengutronix.de>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
 <1439561466-14350-7-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdZ4C25NsrCEHS0hxFx+AkjGfC7cyZeMvixOyoADtcvbmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 7:11 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> This patch adds a sysfs attribute 'name' to gpios that were exported. It
> exposes the newly added name property of gpio descriptors.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

The previous hunk adding the name to the sysfs ABI should
be in this patch.

But I have a problem with this. What is the rationale? The directory
that contains the file already has this name. Why should this
information be duplicated?

Yours,
Linus Walleij
