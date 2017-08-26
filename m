From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 26 Aug 2017 15:50:02 +0530
Subject: [PATCH 00/10] [media] platform: make video_device const
Message-ID: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make make video_device const.

Bhumika Goyal (10):
  [media] cx88: make video_device const
  [media] dt3155: make video_device const
  [media]: marvell-ccic: make video_device const
  [media] mx2-emmaprp: make video_device const
  [media]: s5p-g2d: make video_device const
  [media]: ti-vpe:  make video_device const
  [media] via-camera: make video_device const
  [media]: fsl-viu: make video_device const
  [media] m2m-deinterlace: make video_device const
  [media] vim2m: make video_device const

 drivers/media/pci/cx88/cx88-blackbird.c         | 2 +-
 drivers/media/pci/dt3155/dt3155.c               | 2 +-
 drivers/media/platform/fsl-viu.c                | 2 +-
 drivers/media/platform/m2m-deinterlace.c        | 2 +-
 drivers/media/platform/marvell-ccic/mcam-core.c | 2 +-
 drivers/media/platform/mx2_emmaprp.c            | 2 +-
 drivers/media/platform/s5p-g2d/g2d.c            | 2 +-
 drivers/media/platform/ti-vpe/cal.c             | 2 +-
 drivers/media/platform/ti-vpe/vpe.c             | 2 +-
 drivers/media/platform/via-camera.c             | 2 +-
 drivers/media/platform/vim2m.c                  | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

-- 
1.9.1
