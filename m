From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 5 Mar 2014 09:58:48 +0800
Subject: [PATCH 0/2] spi: atmel: adopt pinctrl support
Message-ID: <1393984730-14828-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, 

This patch is to adopt pinctrl support to optimize energy usage for the pins
both for the suspend/resume cycle.

The patch is based on the branch: for-next
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git

Best Regards,
Wenyou Yang

Wenyou Yang (2):
  spi: atmel: adopt pinctrl support
  ARM: dts: sama5d36ek: add spi pinctrl sleep state

 arch/arm/boot/dts/sama5d36ek.dts |   14 ++++++++++++++
 drivers/spi/spi-atmel.c          |    9 +++++++++
 2 files changed, 23 insertions(+)

-- 
1.7.9.5
