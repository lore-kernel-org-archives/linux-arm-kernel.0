From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 11 Nov 2009 10:30:21 +0100
Subject: drivers/rtc/rtc-pl031.c uses __raw_readl()?
Message-ID: <63386a3d0911110130j2056a355l16cade8d30edb6cd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is there some special reason as to why drivers/rtc/rtc-pl031.c uses
the __raw_[read|write]l() macro instead of plain [read|write]l()?

Is it OK if I just patch this so it looks like the sister pl030 driver?

Linus Walleij
