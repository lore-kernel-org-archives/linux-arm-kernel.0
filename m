From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Tue, 28 Jul 2015 10:24:43 -0500
Subject: [GIT PULL] SoCFPGA updates for v4.3
Message-ID: <1438097083-28875-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please consider pulling these patches for v4.3.

Thanks,
Dinh

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_updates_for_v4.3

for you to fetch changes up to cd871d517d46f26943f3c8f61c0d2ac6665da6a2:

  ARM: socfpga: add reset for the Arria 10 platform (2015-07-20 15:44:43 -0500)

----------------------------------------------------------------
SoCFPGA updates for v4.3
- Add smp.ops.cpu_kill() for kexec
- Add reboot capability for Arria10

----------------------------------------------------------------
Dinh Nguyen (1):
      ARM: socfpga: add reset for the Arria 10 platform

Hiraku Toyooka (1):
      ARM: socfpga: add smp_ops.cpu_kill to make kexec/kdump available

 arch/arm/mach-socfpga/core.h    |  1 +
 arch/arm/mach-socfpga/platsmp.c | 13 +++++++++++++
 arch/arm/mach-socfpga/socfpga.c | 26 ++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
