From: gvormayr@gmail.com (Gernot Vormayr)
Date: Wed, 24 Sep 2014 00:48:36 +0200
Subject: [PATCH 1/1] gpio: Fix ngpio in gpio-xilinx driver
In-Reply-To: <CACRpkdZJajGr+Y4OTBf0W697G9ipBKH-y67EU69C-6cCiVbSRw@mail.gmail.com>
References: <1411031032-20649-1-git-send-email-gvormayr@gmail.com>
 <CACRpkdZJajGr+Y4OTBf0W697G9ipBKH-y67EU69C-6cCiVbSRw@mail.gmail.com>
Message-ID: <CAN+KFvYH_QcaUD5sgqYQTrTtWz7Sh+vV=f=X2D1NFgDBLHqgjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 5:38 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The fact that the same code appears in two places tells us something
> is not quite right. Can you look into consolidating this (in a separate
> patch)?


Well, I already thought about that, but since the second time is for the
second part of a dual gpio, which has different device tree property names,
the only way of consolidating that I can think of right now would be to
create a function that takes the property names. If you think that's ok,
I can try to come up with something.

Cheers,
Gernot Vormayr
