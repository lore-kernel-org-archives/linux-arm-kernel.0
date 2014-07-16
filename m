From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 16 Jul 2014 16:44:58 +0200
Subject: [PATCH v4] 8250-core based serial driver for OMAP
Message-ID: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I converted most of the omap-serial over to the 8250-core based code where it
once was forked from. I dropped the rs485 support for now.
The runtime-pm does not crash any machines because none of them shutdown the
IP core and/or enter deep idle where it would metter.

Sebastian
