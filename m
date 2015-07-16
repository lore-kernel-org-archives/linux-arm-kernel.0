From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 17 Jul 2015 00:09:26 +0200
Subject: [GIT PULL] ARM: mvebu: cleanup changes for v4.3
Message-ID: <55A82B96.3080803@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for cleanup for mvebu for v4.3

Gregory

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-cleanup-4.3-1

for you to fetch changes up to 7a1436d58027f84ae2167b5ec359c15cb1d80837:

  ARM: orion5x: Use vsprintf %pM extension (2015-07-09 14:17:22 +0200)

----------------------------------------------------------------
mvebu cleanup changes for v4.3 (part #1)

- Use vsprintf %pM extension on orion5x board to format mac address
- Add missing newline at end of messages on pr_warn when CPU Idle on
  Armada 38x is disabled

----------------------------------------------------------------
Joe Perches (1):
      ARM: orion5x: Use vsprintf %pM extension

Thomas Petazzoni (1):
      ARM: mvebu: add missing newline at end of messages

 arch/arm/mach-mvebu/pmsu.c           | 4 ++--
 arch/arm/mach-orion5x/dns323-setup.c | 4 +---
 arch/arm/mach-orion5x/tsx09-common.c | 4 +---
 3 files changed, 4 insertions(+), 8 deletions(-)
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
