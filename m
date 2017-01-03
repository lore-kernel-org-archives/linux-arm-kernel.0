From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 3 Jan 2017 10:30:47 +0000
Subject: [GIT PULL] ARM: dts: vexpress: fixes for v4.10
Message-ID: <4df20b4c-3f07-5f1a-2f62-df090aa0cbd6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please pull !

Regards,

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/vexpress-fixes-4.10

for you to fetch changes up to 368400e242dc04963ca5ff0b70654f1470344a0a:

  ARM: dts: vexpress: Support GICC_DIR operations (2016-12-30 14:54:30
+0000)

----------------------------------------------------------------
ARMv7 VExpress fixes for v4.10

A simple fix to extend GICv2 CPU interface registers from 4K to 8K
on VExpress TC1 and TC2 platforms in order to support split priority
drop and interrupt deactivation.

----------------------------------------------------------------
Christoffer Dall (1):
      ARM: dts: vexpress: Support GICC_DIR operations

 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts | 2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
