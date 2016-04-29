From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Apr 2016 16:35:19 +0200
Subject: [GIT PULL] ARM: mvebu: defconfig for v4.7 (#2)
Message-ID: <87pot8sct4.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for defconfig for mvebu for v4.7.

Gregory

The following changes since commit 23d2af622de748bf57d31a4125d06d183c29e908:

  ARM: mvebu_v5_defconfig: Switching to the new Marvell's cryptographic engine driver (2016-04-14 18:57:19 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-4.7-2

for you to fetch changes up to acef3efe096d8de9f115f0d9e9c681147887bcac:

  arm64: marvell: enable AP806 and CP110 syscon driver (2016-04-26 15:20:51 +0200)

----------------------------------------------------------------
mvebu defconfig for 4.7 (part 2)

- enable AP806 and CP110 syscon driver in arm64 defconfig

----------------------------------------------------------------
Thomas Petazzoni (1):
      arm64: marvell: enable AP806 and CP110 syscon driver

 arch/arm64/Kconfig.platforms | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
