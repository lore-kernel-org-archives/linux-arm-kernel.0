From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 31 Jan 2017 15:14:27 +0100
Subject: [GIT PULL] ARM: mvebu: soc for v4.11 (#2)
Message-ID: <87wpdbz58c.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for soc for mvebu for v4.11.

I hope it is not too late, the support for this new SoC needed to have
several iteration and the last one was mainly cosmetic. The code was
in linux-next since last week by the way. SO I don't expect any
regression with it.

Thanks,

Gregory

The following changes since commit f2591b993ec95fd8d67c68187f07f30c9d79b38c:

  soc: dove: constify reset_control_ops structures (2017-01-27 17:52:57 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.11-2

for you to fetch changes up to db88977894aba193deee70b335c3db58b7ac6393:

  arm: mvebu: support for SMP on 98DX3336 SoC (2017-01-30 14:40:56 +0100)

----------------------------------------------------------------
mvebu soc for 4.11 (part 2)

SoC part of the support for the for Marvell switches with integrated
CPUs based on Armada XP: the SMP support is slightly different.

----------------------------------------------------------------
Chris Packham (1):
      arm: mvebu: support for SMP on 98DX3336 SoC

 Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
 .../bindings/arm/marvell/98dx3236-resume-ctrl.txt  | 16 +++++
 arch/arm/mach-mvebu/platsmp.c                      | 75 ++++++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
