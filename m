From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 12 Jul 2018 18:31:02 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.18 (#1)
Message-ID: <87zhywbem1.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.18.

Gregory

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.18-1

for you to fetch changes up to 568cc2f07c8ea5f71a0486464bd9703e4671045f:

  ARM: dts: armada-38x: use the new thermal binding (2018-07-06 16:50:48 +0200)

----------------------------------------------------------------
mvebu fixes for 4.18 (part 1)

Use the new thermal binding on Armada 38x allowing to use a driver fix
which is already part of the kernel.

----------------------------------------------------------------
Baruch Siach (1):
      ARM: dts: armada-38x: use the new thermal binding

 arch/arm/boot/dts/armada-38x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
