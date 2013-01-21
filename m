From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Mon, 21 Jan 2013 11:59:17 +0530
Subject: [PATCH 0/2] ARM: davinci: da850: add ethernet driver DT support
Message-ID: <1358749759-20517-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lad, Prabhakar <prabhakar.lad@ti.com>

This patch set enables Ethernet support through device tree model.

Patches are available on [1] for testing.

[1] http://git.linuxtv.org/mhadli/v4l-dvb-davinci_devices.git/shortlog/refs/heads/da850_dt

Lad, Prabhakar (2):
  ARM: davinci: da850: add DT node for eth0.
  ARM: davinci: da850: add OF_DEV_AUXDATA entry for eth0.

 arch/arm/boot/dts/da850-evm.dts  |    3 +++
 arch/arm/boot/dts/da850.dtsi     |   15 +++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |    9 ++++++++-
 3 files changed, 26 insertions(+), 1 deletions(-)

-- 
1.7.4.1
