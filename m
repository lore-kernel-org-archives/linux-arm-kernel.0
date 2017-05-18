From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 18 May 2017 16:31:29 +0530
Subject: [PATCH 0/2] ARM: davinci_all_defconfig: enble support for USB
 audio/video
Message-ID: <cover.1495104570.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1/2 syncs davinci_all_defconfig with savedefconfig output.
Patch 2/2 enables USB audio and video device support.

Sekhar Nori (2):
  ARM: davinci_all_defconfig: cleanup with savedefconfig
  ARM: davinci_all_defconfig: enable USB audio/video device support

 arch/arm/configs/davinci_all_defconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.9.0
