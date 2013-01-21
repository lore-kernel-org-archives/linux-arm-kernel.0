From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 21 Jan 2013 18:14:18 +0100
Subject: [GIT PULL] arm-soc: Xilinx zynq timer changes for v3.9
Message-ID: <CAHTX3dJ1JdqH9NKYxOYdOE=5x4fMO2JSNMbcq7dkvPNJkC0VAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please pull these timer changes to your arm-soc tree.
I am aware about any dependency.

Please let me know if you have any problem with this patchset.

Thanks,
Michal

The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:
  Linus Torvalds (1):
        Linux 3.8-rc4

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git zynq/timer

Soren Brinkmann (7):
      arm: zynq: timer: Replace PSS through PS
      arm: zynq: timer: Remove unnecessary register write
      arm: zynq: timer: Remove unused #defines
      arm: zynq: timer: Align columns
      arm: zynq: timer: Remove redundant #includes
      arm: zynq: timer: Fix comment style
      arm: zynq: timer: Set clock_event cpumask

 arch/arm/mach-zynq/common.c |    6 +-
 arch/arm/mach-zynq/common.h |    2 +-
 arch/arm/mach-zynq/timer.c  |  150 ++++++++++++++++++++----------------------
 3 files changed, 75 insertions(+), 83 deletions(-)
