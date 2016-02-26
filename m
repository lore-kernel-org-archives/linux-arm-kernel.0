From: dhdang@apm.com (Duc Dang)
Date: Fri, 26 Feb 2016 01:04:29 -0800
Subject: [GIT PULL v2 2/2] arm64: X-Gene platforms DTS changes queued for v4.6
 - part2
Message-ID: <CADaLND==AshC-syR3Tm93bPqB-vEyO3=AY+pM5r_ohgr4n-nBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the second part of DT changes on X-Gene platforms for v4.6,
which enables mailbox driver for X-Gene v1 and X-Gene v2 platforms and
also enable SLIMpro Mailbox I2C driver (a client of the mailbox
driver) for both X-Gene v1 and v2 platforms.

"arm64: dts: apm: mailbox device tree node for APM X-Gene platform"
patch is the 3rd patch
(http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/arch/arm64/boot/dts/apm?id=be9c09bcca039d6df9ec736989cdafc68c93fed4)
of the series "mailbox: Add APM X-Gene platform mailbox driver"
(https://lkml.org/lkml/2016/2/12/749), which was already in linux-next
since Feb-15.

"arm64: dts: apm: Mailbox device tree node for APM X-Gene v2 platform"
is the follow up patch to enable mailbox on X-Gene v2 platform.

The remaining 2 patches enable SLIMpro Mailbox I2C driver on X-Gene v1
and v2 platforms.

Regards,
Duc Dang.
------
The following changes since commit edf21f271024ec6adb93c7b4e6c1dc928b6a7250:

  arm64: dts: apm: Update GPIO to control power-off on X-Gene v2
platforms (2016-02-25 17:14:00 -0800)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.6-part2

for you to fetch changes up to 406f5940549e78fd7d4d41413a7ed3e611bccc4f:

  arm64: dts: apm: Add DT node for X-Gene v2 SLIMpro Mailbox I2C
Driver (2016-02-25 17:14:04 -0800)

----------------------------------------------------------------
Second part of X-Gene DT changes queued for v4.6

This patch set includes:
+ X-Gene v1 and v2 Mailbox DT nodes
+ X-Gene v1 and X-Gene v2 SLIMpro Mailbox
I2C driver DT nodes

----------------------------------------------------------------
Duc Dang (4):
      arm64: dts: apm: mailbox device tree node for APM X-Gene platform.
      arm64: dts: apm: Add DT node for X-Gene v1 SLIMpro Mailbox I2C Driver
      arm64: dts: apm: Mailbox device tree node for APM X-Gene v2 platform.
      arm64: dts: apm: Add DT node for X-Gene v2 SLIMpro Mailbox I2C Driver

 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 19 +++++++++++++++++++
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)
