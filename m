From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 02 Apr 2015 10:54:06 +0200
Subject: [GIT PULL] ARM: mvebu: dt changes for v4.1 (round 3)
Message-ID: <551D03AE.4010105@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the third pull request for dt for mvebu for v4.1.
By the way you didn't pull the second one I sent 10 days
ago. If you prefer I can delete the tags mvebu-dt-4.1-2
and mvebu-dt-4.1-3. And create a new one gathering the
content of the both.

Gregory
The following changes since commit 7776ab70d75ff9857343e44e428744d81c30ce1b:

  ARM: mvebu: armada-385-ap: Enable USB3 port (2015-03-18 11:55:49 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.1-3

for you to fetch changes up to 292a3546b9eb20bf5a292f4e55dd1a027424669f:

  ARM: mvebu: Conform L2CC node with ePAPR specification by adding cache-level (2015-03-19 11:07:47 +0100)

----------------------------------------------------------------
mvebu dt changes for v4.1 (part #3)

These changes have no influence on the kernel behavior (except
removing a warning message), but they allow to have a better
representation of the hardware.

- conform L2CC node with ePAPR specification by adding cache-level
- remove cpuclk resources overlapping coredivclk registers on Armada XP

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: mvebu: Conform L2CC node with ePAPR specification by adding cache-level

Nadav Haklai (1):
      ARM: mvebu: clk: remove cpuclk resources overlapping coredivclk registers on Armada XP

 arch/arm/boot/dts/armada-370.dtsi | 1 +
 arch/arm/boot/dts/armada-xp.dtsi  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
