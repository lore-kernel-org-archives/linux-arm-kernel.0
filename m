From: david@lechnology.com (David Lechner)
Date: Mon, 29 Feb 2016 16:33:23 -0600
Subject: [PATCH 0/3] davinci: device tree - small simplifications
Message-ID: <1456785206-2280-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have been trying out device tree with mach-davinci. Here are some small
simplifications that I have made.

I would also like to know if anyone is working on getting the clocks and related
soc devices (pll and psc) into device tree as well.

David Lechner (3):
  arm: davinci: simplify call to of populate
  arm: davinci: remove unused DA8XX_NUM_UARTS
  arm: davinci: use IRQCHIP_DECLARE for cp_intc

 arch/arm/mach-davinci/cp_intc.c  |  3 +++
 arch/arm/mach-davinci/da8xx-dt.c | 17 +----------------
 2 files changed, 4 insertions(+), 16 deletions(-)

-- 
1.9.1
