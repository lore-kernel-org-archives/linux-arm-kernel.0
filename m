From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 8 Sep 2010 16:26:12 +0200
Subject: [00/12] DMAENGINE: PL08X driver updates
In-Reply-To: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTi==kKBdOaim+fx5yhpKOo27HWhB7kQiDqv0+BPS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/31 Linus Walleij <linus.walleij@stericsson.com>:

> This updates the PL08X driver in the async_tx next branch with
> a number of fixes and features, each one pretty self-describing.
> This has been tested with the PrimeCell DMA series on the
> RealView PB11MPCore and works flawlessly, multiplexing
> several virtual clients, both devices (slaves) and memcpy
> channels, across only two (!) available physical channels.

Dan can you ACK and queue this for next?

I know you're busy, just a reminder...

Yours,
Linus Walleij
