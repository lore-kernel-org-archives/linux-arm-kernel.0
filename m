From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 09:23:24 +0200
Subject: [PATCH 11/11] i2c: omap: enhance pinctrl support
In-Reply-To: <87bo7r10s9.fsf@linaro.org>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
 <1369995191-20855-12-git-send-email-gururaja.hebbar@ti.com>
 <87bo7r10s9.fsf@linaro.org>
Message-ID: <CACRpkdaTHsHzu1dyOBoNn77+U5r5oJ0ueUv=W8g41Nb0X1qtTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 8:07 PM, Kevin Hilman <khilman@linaro.org> wrote:

> But that brings up a bigger question about whether or not we should be
> doing the rest of this (idle/sleep) pin management in the drivers or in
> the driver core as well.  I would much prefer it be handled by the
> driver core.

Yes. See my suggestion in 2/11.

> In fact, since these are all PM related events, it should probably be
> handled by the PM core and seems pretty straight forward to do so.

I can see a clean interface with three simple functions toward
<pinctrl/consumer.h> for switching between the default, idle and
sleep states, but you may see even further...

Yours,
Linus Walleij
