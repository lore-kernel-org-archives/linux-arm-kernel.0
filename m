From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 20 Dec 2013 11:45:39 +0100
Subject: ARM: AT91: remove unused pit irq hander and allow higher clockrates
 for TCLIB
Message-ID: <1387536341-7452-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

these two patches have been sitting in the -RT tree for quite some time
now. Many thanks to Sami Pietik?inen who fixed them while they got broken
somewhere between v3.2 and v3.8. I ported them to v3.13-rc4 and compile
tested but I have no HW to do more testing.


Sebastian
