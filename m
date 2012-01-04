From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 4 Jan 2012 13:50:36 +0800
Subject: [GIT PULL] pxa for-next for V3.3
Message-ID: <CAN1soZxoJcmBff7PVLvMHTd2FZ3=wYWoR2TOtPQYxPnHogf6kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please help to merge these patches from for-next branch of pxa git tree.

The following changes since commit 157e8bf8b4823bfcdefa6c1548002374b61f61df:

  Revert "rtc: Disable the alarm in the hardware" (2012-01-03 17:32:13 -0800)

are available in the git repository at:
  http://github.com/hzhuang1/linux.git for-next

Axel Lin (2):
      pxa/hx4700: add platform device and I2C info for AK4641 codec
      ARM: pxa: fix error handling in pxa2xx_drv_pcmcia_probe

 arch/arm/mach-pxa/hx4700.c   |   25 +++++++++++++++++++++++++
 drivers/pcmcia/pxa2xx_base.c |   12 +++---------
 2 files changed, 28 insertions(+), 9 deletions(-)

Best Regards
Haojian
