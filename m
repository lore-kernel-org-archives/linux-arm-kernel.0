From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 4 Jun 2013 09:54:33 -0400
Subject: [GIT PULL 2/2] ARM: mvebu: pcie kirkwood for v3.11 (round 2)
Message-ID: <20130604135433.GD3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

Here's a patch catching up a missed board in the DT conversion of
kirkwood pcie.  There shouldn't be any more like this, so I'm just
sending the single patch.

This has also been in -next for five days or so.


The following changes since commit 0d0632f523fa040b307688ae421a1debf79af2d7:

  arm: kirkwood: convert db-88f6281/db-88f6282 to the Device Tree (2013-05-27 16:02:13 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/pcie_kw-3.11-2

for you to fetch changes up to 6bd98481ab346964344e05a041f35ff83cb3d00c:

  arm: kirkwood: NETGEAR ReadyNAS Duo v2 init PCIe via DT (2013-05-29 11:45:24 +0000)

----------------------------------------------------------------
mvebu pcie driver (kirkwood) for v3.11 (round 2)

 - kirkwood
    - migrate Netgear ReadyNAS Duo v2 to pcie DT init

depends
 - mvebu/pcie
    - mvebu/of_pci

----------------------------------------------------------------
Arnaud Ebalard (1):
      arm: kirkwood: NETGEAR ReadyNAS Duo v2 init PCIe via DT

 arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 8 ++++++++
 arch/arm/mach-kirkwood/board-readynas.c                | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)
