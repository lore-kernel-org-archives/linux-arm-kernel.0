From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 16 Jul 2015 19:03:34 +0530
Subject: [PATCH 0/2] ARM: dts: dra7x-evm: fix incorrect compatibles
Message-ID: <cover.1437053417.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Here non-critical compatible name fix
for DRA7x EVM for v4.3

Thanks,
Sekhar

Sekhar Nori (2):
  ARM: dts: dra7-evm: fix compatible name for pcf8575
  ARM: dts: dra72-evm: fix compatible name for pcf8575

 arch/arm/boot/dts/dra7-evm.dts  | 2 +-
 arch/arm/boot/dts/dra72-evm.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.4.4.408.g16da57c
