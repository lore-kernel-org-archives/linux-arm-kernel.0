From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 09 Oct 2015 18:08:37 +0200
Subject: [GIT PULL] ARM: mvebu: soc for v4.4
Message-ID: <87k2qwrpmi.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for soc for mvebu for v4.4.

Gregory

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.4-1

for you to fetch changes up to d492cccac28493f26bb70038385a9ef4df19bdee:

  ARM: mvebu: add support to clear shared L2 bit on Armada XP (2015-09-29 15:31:51 +0200)

----------------------------------------------------------------
mvebu soc for 4.4 (part 1)

L2 caches optimization for Armada XP

----------------------------------------------------------------
Thomas Petazzoni (1):
      ARM: mvebu: add support to clear shared L2 bit on Armada XP

 .../devicetree/bindings/arm/mvebu-cpu-config.txt   | 20 ++++++++
 arch/arm/mach-mvebu/coherency.c                    | 60 ++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644
 Documentation/devicetree/bindings/arm/mvebu-cpu-config.txt

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
