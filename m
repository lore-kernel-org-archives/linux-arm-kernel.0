From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 01 Sep 2017 17:15:58 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.13 (#3)
Message-ID: <87wp5io3f5.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the third pull request for fixes for mvebu for v4.13.

Gregory

The following changes since commit d7a65c4905bc9c304ecf3d8aa566802f6119480f:

  ARM64: dts: marvell: armada-37xx: Fix the number of GPIO on south bridge (2017-08-02 16:00:00 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.13-3

for you to fetch changes up to a0ac89b57207ccc87d76f4e6aa9a83026743861b:

  arm64: dts: marvell: fix number of GPIOs in Armada AP806 description (2017-08-30 15:50:13 +0200)

----------------------------------------------------------------
mvebu fixes for 4.13 (part 3)

Fix number of GPIOs in AP806 description for Armada 7K/8K

----------------------------------------------------------------
Thomas Petazzoni (1):
      arm64: dts: marvell: fix number of GPIOs in Armada AP806 description

 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
