From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Wed, 4 Jan 2012 12:47:47 +0530
Subject: [PATCH v8 0/2]remove machine specific header file inclusion from
 driver
Message-ID: <1325661469-4411-1-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove unnecessary inclusion of machine specific header
file from driver which comes in the way of platform code
consolidation.


Manjunath Hadli (2):
  davinci: vpif: remove machine specific header file inclusion from the
    driver
  davinci: CQ93VC: remove machine specific header file inclusion from
    codec driver

 drivers/media/video/davinci/vpif.h         |    2 --
 drivers/media/video/davinci/vpif_display.c |    2 --
 include/media/davinci/vpif_types.h         |    2 ++
 sound/soc/codecs/cq93vc.c                  |    2 --
 4 files changed, 2 insertions(+), 6 deletions(-)
