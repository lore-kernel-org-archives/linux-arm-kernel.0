From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Oct 2013 18:58:34 +0200
Subject: [PATCH 1/2] leds: lp55xx: handle enable pin in driver
In-Reply-To: <CACRpkdZzoQ4auk1Q1wB=H-i4Aw7tPaHf3J8Dsa3vA_0Wx65qtw@mail.gmail.com>
References: <1382446896-28436-1-git-send-email-sre@debian.org>
 <1382446896-28436-2-git-send-email-sre@debian.org>
 <CACRpkdZzoQ4auk1Q1wB=H-i4Aw7tPaHf3J8Dsa3vA_0Wx65qtw@mail.gmail.com>
Message-ID: <CACRpkda0+ZG0_0pGGziqyhL1kARxY3YtM-Hn-47DXdNP4WS9Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 6:57 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> BTW: should we disable the GPIO when remove()ing the module?
> This is a topic of another patch but...

Bah forget this stupid comment, I misread it, obviously
you're doing this.

Yours,
Linus Walleij
