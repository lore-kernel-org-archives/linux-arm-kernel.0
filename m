From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 16 May 2013 12:27:20 +0100
Subject: [PATCH 0/6] crypto: ux500/[cryp|hash] - Enable Device Tree
Message-ID: <1368703646-26418-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set simply allows ux500-[cryp|hash] drivers to be probed
when Snowball is running with Device Tree enabled.

Linus,

Feel free to split the DTS changes out into your ux500-devicetree branch.

 arch/arm/boot/dts/dbx5x0.dtsi         |   17 +++++++++++++++++
 arch/arm/boot/dts/snowball.dts        |    8 ++++++++
 arch/arm/mach-ux500/cpu-db8500.c      |    2 ++
 drivers/crypto/ux500/cryp/cryp_core.c |    6 ++++++
 drivers/crypto/ux500/hash/hash_core.c |    6 ++++++
 5 files changed, 39 insertions(+)
