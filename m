From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 18 Jun 2016 10:30:18 +0200
Subject: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
In-Reply-To: <5761265F.2050508@ti.com>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdaVRTj4jpGQp9nDKo8RAPDPUaApp4jAdBGRgd45bqo2zQ@mail.gmail.com>
 <20160615072404.GB26768@pengutronix.de> <20160615082705.GW22406@atomide.com>
 <5761265F.2050508@ti.com>
Message-ID: <CACRpkdZ178-P=uVx7PTZdR4ut6fToNbNn+d70y21QRKtwrk9Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 11:56 AM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> Wouldn't gpio-line-names be helpful for such cases as mentioned in [1],[2]
> But I don't know it these properties were exposed in legacy GPIO sysfs interface also.

The line names only expose through the chardev interface because the
sysfs ABI is frozen and should not be extended.

Yours,
Linus Walleij
