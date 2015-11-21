From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 21 Nov 2015 19:04:47 +0100
Subject: [PATCH 0/6] pinctrl: pxa: add pxa27x pin control support
Message-ID: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I've been working on this for some time now, it's time pxa archtecture gets a
proper pin control support.

This serie provides support for pxa27x architecture, and paves the way to pxa2xx
one. I've tested this on my pxa27x board, in both device-tree and non
device-tree builds.

It's time to have more eyes on this code, so let's begin the review.

Cheers.

Robert Jarzmik (6):
  MAINTAINERS: add to pxa files pinctrl
  pinctrl: pxa: pxa2xx: add pin control skeleton
  pinctrl: pxa: pxa2xx: add pin muxing
  pinctrl: pxa: pxa2xx: add pin configuration support
  pinctrl: pxa: add pxa27x architecture
  pinctrl: activate pxa architecture

 MAINTAINERS                          |   1 +
 drivers/pinctrl/Kconfig              |   1 +
 drivers/pinctrl/Makefile             |   1 +
 drivers/pinctrl/pxa/Kconfig          |  17 ++
 drivers/pinctrl/pxa/Makefile         |   2 +
 drivers/pinctrl/pxa/pinctrl-pxa27x.c | 566 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 436 +++++++++++++++++++++++++++
 drivers/pinctrl/pxa/pinctrl-pxa2xx.h |  92 ++++++
 8 files changed, 1116 insertions(+)
 create mode 100644 drivers/pinctrl/pxa/Kconfig
 create mode 100644 drivers/pinctrl/pxa/Makefile
 create mode 100644 drivers/pinctrl/pxa/pinctrl-pxa27x.c
 create mode 100644 drivers/pinctrl/pxa/pinctrl-pxa2xx.c
 create mode 100644 drivers/pinctrl/pxa/pinctrl-pxa2xx.h

-- 
2.1.4
