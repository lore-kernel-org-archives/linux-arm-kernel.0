From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 8 Mar 2016 16:48:52 +0000
Subject: [GIT PULL] arm64: dts: vexpress/juno: Updates for v4.6(part 2)
Message-ID: <56DF0274.1060007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Sorry for the late pull request.

There's one update for adding support for SBSA Watchdog to foundation
model that caused conflict as it was merged via watchdog tree. I am
pulling that now to avoid conflicts and I also have a patch to fix DT
warnings that new checks in DTS introduced since last Friday. Please
consider pulling this for v4.6

Regards,
Sudeep


The following changes since commit 9fd9288ed0899f9e318a97d73e777d6d3357265e:

   arm64: dts: Add HDLCD support on Juno platforms (2016-02-10 10:58:33 
+0000)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git 
tags/vexpress-for-v4.6/dt-updates-2

for you to fetch changes up to 6d6acd140ab3d46348ec3a9dbfd386d9ca42b825:

   arm64: dts: juno/vexpress: fix node name unit-address presence 
warnings (2016-03-08 13:54:27 +0000)

----------------------------------------------------------------
Additional updates for ARM VExpress/Juno platforms

1. Add support for SBSA Generic Watchdog on foundation models

2. Fix node name unit-address presence/absence mismatch warnings in
    all the device trees

----------------------------------------------------------------
Fu Wei (1):
       arm64: dts: foundation-v8: add SBSA Generic Watchdog device node

Sudeep Holla (1):
       arm64: dts: juno/vexpress: fix node name unit-address presence 
warnings

  arch/arm64/boot/dts/arm/foundation-v8.dtsi         | 10 +++++++-
  arch/arm64/boot/dts/arm/juno-base.dtsi             | 14 +++++-----
  arch/arm64/boot/dts/arm/juno-motherboard.dtsi      | 30 
+++++++++++-----------
  arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |  2 +-
  arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi   | 14 +++++-----
  .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      | 10 ++++----
  6 files changed, 44 insertions(+), 36 deletions(-)
