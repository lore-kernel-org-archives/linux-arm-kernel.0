From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 22 Mar 2013 19:49:46 +0100
Subject: [PATCH 0/2] Add dbg_show functions to the Marvell GPIO drivers
Message-ID: <1363978188-31200-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are two patches I have used to validate the patch series:
"refactoring for mask_cache".

They adds dedicated dbg_show functions to the Marvell GPIO drivers
mvebu-gpio and orion-gpio. This allows to display the SoC specific
GPIO informations in addition to the generic gpiolib debug output.

Regards,

Simon

Simon Guinot (2):
  gpio: mvebu: add dbg_show function
  ARM: Orion: add dbg_show function to gpio-orion driver

 arch/arm/plat-orion/gpio.c |   59 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-mvebu.c  |   59 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

-- 
1.7.10.4
