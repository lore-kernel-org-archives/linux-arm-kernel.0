From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Thu, 10 Nov 2016 16:09:31 +0100
Subject: [GIT PULL]: ARM ARTPEC changes for 4.10
Message-ID: <20161110150930.GB19804@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Please pull the below signed tag for a trio of minor changes
adding PCIe for the ARM ARTPEC SoC.

Thanks!

/Jesper

The following changes since commit bc33b0ca11e3df467777a4fa7639ba488c9d4911:

  Linux 4.9-rc4 (2016-11-05 16:23:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jesper/artpec.git tags/artpec-for-4.10

for you to fetch changes up to fa5541fc806771a108cd2a48245a229f1ba539ea:

  ARM: dts: artpec: add pcie support (2016-11-10 15:51:10 +0100)

----------------------------------------------------------------
ARTPEC changes for 4.10

----------------------------------------------------------------
Niklas Cassel (3):
      ARM: ARTPEC-6: add select MFD_SYSCON to MACH_ARTPEC6
      ARM: ARTPEC-6: add pcie related options
      ARM: dts: artpec: add pcie support

 arch/arm/boot/dts/artpec6-devboard.dts |  4 ++++
 arch/arm/boot/dts/artpec6.dtsi         | 29 ++++++++++++++++++++++++++++-
 arch/arm/mach-artpec/Kconfig           |  3 +++
 3 files changed, 35 insertions(+), 1 deletion(-)

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
