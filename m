From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Jul 2012 08:34:01 +0200
Subject: [PATCH v2] i.MX defconfig updates
Message-ID: <1341988443-5534-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


v2: Enable some more drivers useful to get more compiler coverage.

----------------------------------------------------------------
Sascha Hauer (2):
      ARM: imx_v6_v7_defconfig: update features
      ARM: imx_v4_v5_defconfig: update features

 arch/arm/configs/imx_v4_v5_defconfig |   51 ++++++++++++++--------------
 arch/arm/configs/imx_v6_v7_defconfig |   61 ++++++++++++++++++++--------------
 2 files changed, 61 insertions(+), 51 deletions(-)
