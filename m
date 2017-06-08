From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 8 Jun 2017 20:07:31 +0530
Subject: [PATCH 0/2] ARM: davinci_all_defconfig: some defconfig updates
Message-ID: <20170608143733.30004-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are two more defconfig updates enabling modules
used frequently on DaVinci devices.

Sekhar Nori (2):
  ARM: davinci_all_defconfig: enable mtdtests
  ARM: davinci_all_defconfig: enable USB CDC NCM gadget

 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.9.0
