From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 10 Sep 2014 21:29:55 +0200
Subject: [PATCH 00/16 v9] omap 8250 based uart + DMA
Message-ID: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the diff of v8?v9 is small:
- rebased on top's of Greg's tty-next branch
- fixed #10 where we might have THRE interrupt enabled for longer than
  needed
- re-did register setup in #10. Before this "less file" could freeze the
  am335x-evm.

Sebastian
