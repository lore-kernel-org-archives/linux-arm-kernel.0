From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 21 Sep 2012 16:26:56 +0800
Subject: [GIT PULL][for 3.6] pull request on fixes branch from arch-pxa
Message-ID: <CAN1soZwLHZTudFVMQWaE43TPPtsGxYDZQSYfkkY1svVwbfSaUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Arnd,

Please help to merge fixes branch in arch-pxa git tree.

Regards
Haojian

The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:

  Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git fixes

for you to fetch changes up to e09a716490dbce0b9b7d132d191f1f8785cb5df2:

  ARM: pxa: fix return value check in pxa2xx_drv_pcmcia_probe()
(2012-09-21 15:33:58 +0800)

----------------------------------------------------------------
Wei Yongjun (1):
      ARM: pxa: fix return value check in pxa2xx_drv_pcmcia_probe()

 drivers/pcmcia/pxa2xx_base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
