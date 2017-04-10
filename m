From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Apr 2017 22:37:56 +0800
Subject: [GIT PULL 5/5] i.MX defconfig updates for 4.12
In-Reply-To: <1491835076-1995-1-git-send-email-shawnguo@kernel.org>
References: <1491835076-1995-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1491835076-1995-5-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.12

for you to fetch changes up to c5054a98bce49ab2956e0dbc3fdfd6345716b16b:

  ARM: imx_v6_v7_defconfig: Select SMSC_PHY (2017-03-30 21:21:34 +0800)

----------------------------------------------------------------
i.MX defconfig updates for 4.12:
 - Enable MAX11801 and HID_MULTITOUCH touch drivers.
 - Enable SMSC_PHY driver, as imx6sl-evk board has a LAN8720A ethernet
   phy supported by it.

----------------------------------------------------------------
Jagan Teki (2):
      ARM: imx_v6_v7_defconfig: Select max11801_ts touchscreen driver
      ARM: imx_v6_v7_defconfig: Select hid-multitouchdriver

Leonard Crestez (1):
      ARM: imx_v6_v7_defconfig: Select SMSC_PHY

 arch/arm/configs/imx_v6_v7_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
