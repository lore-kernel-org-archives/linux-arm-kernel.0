From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 13 Jun 2010 11:31:47 +0300
Subject: [PATCH 0/2] [ARM] pxa3xx: enable the IRQ_WAKEUPx to be a wakeup
	source.
Message-ID: <1276417909-22980-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hardware specific setup should be done to enable
the IRQ_WAKEUPx as a wakeup source on pxa3xx cpu.
This patch series enables the IRQ_WAKEUPx to be
a wakeup source and makes use of it on cm-x300.

Igor Grinberg (2):
  [ARM] pxa3xx: add set_type to the ext_wakeup irq chip.
  [ARM] pxa/cm-x300: enable the IRQ_WAKEUP0 as wakeup source.

 arch/arm/mach-pxa/cm-x300.c |    1 +
 arch/arm/mach-pxa/pxa3xx.c  |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)
