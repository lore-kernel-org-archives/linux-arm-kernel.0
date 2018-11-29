From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 29 Nov 2018 10:00:47 +0100
Subject: [PATCH v2 0/1] media: cedrus: Remove global IRQ spin lock from the
 driver
Message-ID: <20181129090048.16482-1-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
* Reworked commit message as suggested by Maxime.

Paul Kocialkowski (1):
  media: cedrus: Remove global IRQ spin lock from the driver

 drivers/staging/media/sunxi/cedrus/cedrus.c       |  1 -
 drivers/staging/media/sunxi/cedrus/cedrus.h       |  2 --
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c   |  9 ---------
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c    | 13 +------------
 drivers/staging/media/sunxi/cedrus/cedrus_video.c |  5 -----
 5 files changed, 1 insertion(+), 29 deletions(-)

-- 
2.19.1
