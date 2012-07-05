From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  5 Jul 2012 09:11:23 +0200
Subject: [PATCH] update imx defconfigs
Message-ID: <1341472285-1061-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

General i.MX defconfig update. Contains the changes from the mailing lists,
mostly from Fabio, plus some additional things.

Sascha

----------------------------------------------------------------
Sascha Hauer (2):
      ARM: imx_v6_v7_defconfig: update features
      ARM: imx_v4_v5_defconfig: update features

 arch/arm/configs/imx_v4_v5_defconfig |   44 +++++++++++++--------------
 arch/arm/configs/imx_v6_v7_defconfig |   54 ++++++++++++++++++----------------
 2 files changed, 50 insertions(+), 48 deletions(-)
