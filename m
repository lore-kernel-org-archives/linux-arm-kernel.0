From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Nov 2012 08:45:53 -0600
Subject: [GIT PULL] Calxeda cpuidle support
Message-ID: <50AA4621.20509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please pull cpuidle support for highbank. This is the first driver in
drivers/cpuidle. All the existing drivers for ARM are in arch/arm. I'm
asking for you to pull since there seems to be a lack of maintainer for
cpuidle drivers.

Regards,
Rob

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

  Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git tags/highbank-cpuidle

for you to fetch changes up to be6a98d3f00c292d347465d96acbec9d8c2783cf:

  cpuidle: add Calxeda SOC idle support (2012-11-07 17:15:36 -0600)

----------------------------------------------------------------
Add cpuidle driver support for Calxeda Highbank SOC.

----------------------------------------------------------------
Rob Herring (1):
      cpuidle: add Calxeda SOC idle support

 drivers/cpuidle/Kconfig           |   10 +++
 drivers/cpuidle/Makefile          |    2 +
 drivers/cpuidle/cpuidle-calxeda.c |  161
+++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-calxeda.c
