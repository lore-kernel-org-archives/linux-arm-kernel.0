From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sat, 29 Sep 2018 17:18:04 +0200
Subject: [GIT PULL] ARM: dts updates for arm 32 bits for v4.20
Message-ID: <0195dc38-908e-c403-5f12-d266a037ca1b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Please take the following pull request into account.

Thanks a lot,
Matthias


---

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.19-next-dts32

for you to fetch changes up to 5646a2f6d584e80bd4555c2ce3e286b35b9eaa61:

  arm: dts: mt7623: add jpeg decoder device node (2018-09-25 17:44:35 +0200)

----------------------------------------------------------------
mt7623:
- add pmu node
- add subsystem clocks
- add nodes needed for iommu
- add node for the jpeg decoder

----------------------------------------------------------------
Ryder Lee (4):
      arm: dts: mt7623: add a performance counter unit device node
      arm: dts: mt7623: update subsystem clock controller device nodes
      arm: dts: mt7623: add iommu/smi device nodes
      arm: dts: mt7623: add jpeg decoder device node

 arch/arm/boot/dts/mt7623.dtsi | 124 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)
