From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 Aug 2010 14:12:02 +0200
Subject: [00/12] DMAENGINE: PL08X driver updates
Message-ID: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

This updates the PL08X driver in the async_tx next branch with
a number of fixes and features, each one pretty self-describing.
This has been tested with the PrimeCell DMA series on the
RealView PB11MPCore and works flawlessly, multiplexing
several virtual clients, both devices (slaves) and memcpy
channels, across only two (!) available physical channels.

If you prefer you can squash these into the initial driver
submission, I don't mind.

Yours,
Linus Walleij
