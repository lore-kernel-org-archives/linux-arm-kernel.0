From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 3 Jan 2017 10:31:52 +0000
Subject: [GIT PULL] arm64: dts: vexpress: fixes for v4.10
Message-ID: <252d452b-49a3-6c62-b299-ed7a2abbf538@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please pull !

Regards,
Sudeep

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/juno-fixes-4.10

for you to fetch changes up to 1dff32d7df7ff5d80194ebce7ab5755b32564e13:

  arm64: dts: vexpress: Support GICC_DIR operations (2016-12-30 15:31:24
+0000)

----------------------------------------------------------------
ARMv8 Juno/VExpress fixes for v4.10

A simple fix to extend GICv2 CPU interface registers from 4K to 8K
on AEMv8 FVP/RTSM models in order to support split priority drop and
interrupt deactivation.

----------------------------------------------------------------
Sudeep Holla (1):
      arm64: dts: vexpress: Support GICC_DIR operations

 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
