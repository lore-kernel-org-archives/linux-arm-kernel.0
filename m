From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Aug 2013 15:20:09 +0200
Subject: [PATCH] gpio/mxc: add chained_irq_enter/exit() to
 mx2_gpio_irq_handler
In-Reply-To: <20130730073917.GL1754@pengutronix.de>
References: <1374152286-12955-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdZjsAOtm2Jt7kY-VC2ToFfMQ+UxjWQE7aUZAbsBt0ugvw@mail.gmail.com>
 <20130730073917.GL1754@pengutronix.de>
Message-ID: <CACRpkdaph+44SG5+VoSCiqkwMpjDO8Vc3ZVwVnhywx7DD5=-Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 9:39 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:


>> The encoding is what screw things up.

> That means git is unable to apply base64 encoded mail? Hmm, testing with
> git 1.8.3.2 (from Debian) I can apply the base64 encoded patch.
> Does your git have 87ab799234639c26ea10de74782fa511cb3ca606 (i.e. is
> older than 1.5.1)?

Hm it works, I just never tried it ... nevermind.

Patch applied with Shawn's ACK.

Yours,
Linus Walleij
