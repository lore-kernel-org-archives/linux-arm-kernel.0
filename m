From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Mon, 15 Jun 2015 22:21:35 -0500
Subject: [GIT PULL] SoCFPGA updates for v4.2, part 3
Message-ID: <1434424895-4047-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof:

If it's not too late for v4.2, can you please pull in this patch.

Thanks,
Dinh

The following changes since commit 89b8da06ba302dd130df60df7964ccd3ab151cd6:

  ARM: socfpga: fix build error due to secondary_startup (2015-06-11 15:41:58 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_updates_for_v4.2_part3

for you to fetch changes up to e93d3f09af506c4e7f9188033a1357ce5098f1cf:

  ARM: socfpga: add smp_ops.cpu_kill to make kexec/kdump available (2015-06-15 22:13:01 -0500)

----------------------------------------------------------------
SoCFPGA update for v4.2, part 3
- Add smp.ops.cpu_kill() for kexec

----------------------------------------------------------------
Hiraku Toyooka (1):
      ARM: socfpga: add smp_ops.cpu_kill to make kexec/kdump available

 arch/arm/mach-socfpga/platsmp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)
