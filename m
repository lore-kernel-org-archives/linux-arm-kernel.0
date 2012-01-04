From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 4 Jan 2012 13:52:32 +0800
Subject: [GIT PULL] pxa gpio for V3.3
Message-ID: <CAN1soZyqP_oXOt62mCpAGb48qqMa+wous0FP+SS6aCduqFyVvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull these patches from pxa gpio branch.

The following changes since commit b5d798cc7a221aec50baf496c482280f1b809143:

  Input: zylonite-wm97xx - replace IRQ_GPIO() with gpio_to_irq()
(2011-12-28 10:14:18 +0000)

are available in the git repository at:
  http://github.com/hzhuang1/linux.git gpio

Haojian Zhuang (2):
      gpio: pxa: request pinmux function for gpio
      ARM: mmp: fix missing gpio name in irq resource

 arch/arm/mach-mmp/mmp2.c   |    1 +
 arch/arm/mach-mmp/pxa168.c |    1 +
 arch/arm/mach-mmp/pxa910.c |    1 +
 drivers/gpio/gpio-pxa.c    |   13 +++++++++++++
 4 files changed, 16 insertions(+), 0 deletions(-)

Best Regards
Haojian
