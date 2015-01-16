From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 16 Jan 2015 16:31:04 +0100
Subject: [PATCH v3 0/3] pinctrl: at91: allow disabled gpio controllers
Message-ID: <1421422267-2934-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes from v2:
- I have taken Jean-Christophe patch and squash some parts of my previous
patch since probe fails

Jean-Christophe PLAGNIOL-VILLARD (1):
  pinctrl: at91: allow to have disabled gpio bank

Ludovic Desroches (2):
  ARM: at91/dt: sama5d4: add pioD controller
  MAINTAINERS: add maintainer for pinctrl-at91

 MAINTAINERS                    |   1 +
 arch/arm/boot/dts/sama5d4.dtsi |  13 +++++
 drivers/pinctrl/pinctrl-at91.c | 108 +++++++++++++++++++++--------------------
 3 files changed, 69 insertions(+), 53 deletions(-)

-- 
2.2.0
