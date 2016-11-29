From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 29 Nov 2016 14:54:46 +0530
Subject: [PATCH 0/2] ARM: dts: dra7-evm: pinmuxing updates
Message-ID: <cover.1480411308.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series drops most of the pinmuxing from dra7-evm
to satisfy erratum i869 and adds missing eMMC and SD card pinmuxing.

The patches apply to latest linux-next. Tested on DRA74x EVM Rev H
using U-Boot 2016.11. Boot tested using NFS and basic testing carried
out on SD card, eMMC, Audio capture and playback.

Kishon Vijay Abraham I (1):
  ARM: dts: dra7-evm: add pinmux configuration for mmc1/2

Sekhar Nori (1):
  ARM: dts: dra7-evm: Remove pinmux configurations for erratum i869

 arch/arm/boot/dts/dra7-evm.dts | 275 ++++-------------------------------------
 1 file changed, 23 insertions(+), 252 deletions(-)

-- 
2.9.0
