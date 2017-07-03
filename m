From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Jul 2017 15:39:12 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 (aka late fixe) for v4.13 (#3)
Message-ID: <8760f9vdvj.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the third pull request for dt64 for mvebu for v4.13. As
explained in the tags, it is actually a patch fix that missed the end
of the 4.12 merge window for bug fixes. So it would be nice to have it
applied during the 4.13 merge window.

Thanks,

Gregory

The following changes since commit 6ef84a827c37547504514a80bdb35f74a67df5a3:

  arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K (2017-06-21 17:09:48 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.13-3

for you to fetch changes up to 88cda00733f0731711c76e535d4972c296ac512e:

  ARM64: dts: marvell: armada37xx: Fix timer interrupt specifiers (2017-07-03 15:24:31 +0200)

----------------------------------------------------------------
late dt64 for 4.13

It is actually a patch that missed the end of the 4.12 merge
window. The patch itself fix a bogus definition of the timer for the
Armada 37xx SoCs.

----------------------------------------------------------------
Marc Zyngier (1):
      ARM64: dts: marvell: armada37xx: Fix timer interrupt specifiers

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)
