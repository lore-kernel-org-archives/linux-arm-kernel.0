From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 8 Mar 2016 16:49:02 +0000
Subject: [GIT PULL] ARM: dts: vexpress: fixes for v4.6
Message-ID: <56DF027E.3070807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Sorry for the late pull request, but these DTC checks were introduced in
-next last Friday. Please consider pulling this for v4.6

Regards,
Sudeep

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git 
tags/vexpress-for-v4.6/armv7-dt-updates

for you to fetch changes up to 929d755dbda796003a2eac981958def545efedf0:

   ARM: dts: vexpress: fix node name unit-address presence warnings 
(2016-03-08 14:52:34 +0000)

----------------------------------------------------------------
Update for ARM VExpress platforms

Just one update to fix node name unit-address presence/absence mismatch
warnings in all the Vexpress device trees.

----------------------------------------------------------------
Sudeep Holla (1):
       ARM: dts: vexpress: fix node name unit-address presence warnings

  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi     | 44 
++++++++++++++---------------
  arch/arm/boot/dts/vexpress-v2m.dtsi         | 44 
++++++++++++++---------------
  arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts | 34 +++++++++++-----------
  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  | 44 
++++++++++++++---------------
  arch/arm/boot/dts/vexpress-v2p-ca5s.dts     | 24 ++++++++--------
  arch/arm/boot/dts/vexpress-v2p-ca9.dts      | 28 +++++++++---------
  6 files changed, 109 insertions(+), 109 deletions(-)
