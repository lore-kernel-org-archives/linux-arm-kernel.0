From: dhdang@apm.com (Duc Dang)
Date: Thu, 25 Feb 2016 18:51:59 -0800
Subject: [GIT PULL 2/2] arm64: X-Gene platforms DTS changes queued for v4.6 -
 part2
Message-ID: <CADaLNDkF8_DVYWPFtGU8tYsbbxDWZF9tozW=Zs3EuV4BqO6OuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the second part of DT changes on X-Gene platforms for v4.6,
which enables mailbox driver for X-Gene v2 platforms and also enable
SLIMpro Mailbox I2C driver (a client of the mailbox driver) for both
X-Gene v1 and v2 platforms.

This series depends on the 3rd patch
(http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/arch/arm64/boot/dts/apm?id=be9c09bcca039d6df9ec736989cdafc68c93fed4)
of the series "mailbox: Add APM X-Gene platform mailbox driver"
(https://lkml.org/lkml/2016/2/12/749), which was already in linux-next
since Feb-15.

Hi Jassi,

Are you going to get the 3rd patch (dts patch) of series "mailbox: Add
APM X-Gene platform mailbox driver" to your tree? Otherwise, I will
need to create another pull request for Arnd and Olof.

Regards,
Duc Dang.
------

The following changes since commit b0e4563c2f6d939a124f06e10b205151bbac487c:

  arm64: dts: apm: mailbox device tree node for APM X-Gene platform.
(2016-02-25 17:14:01 -0800)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.6-part2

for you to fetch changes up to 406f5940549e78fd7d4d41413a7ed3e611bccc4f:

  arm64: dts: apm: Add DT node for X-Gene v2 SLIMpro Mailbox I2C
Driver (2016-02-25 17:14:04 -0800)

----------------------------------------------------------------
Second part of X-Gene DT changes queued for v4.6

This patch set includes:
+ X-Gene v2 Mailbox DT node
+ X-Gene v1 and X-Gene v2 SLIMpro Mailbox
I2C driver DT nodes

----------------------------------------------------------------
Duc Dang (3):
      arm64: dts: apm: Add DT node for X-Gene v1 SLIMpro Mailbox I2C Driver
      arm64: dts: apm: Mailbox device tree node for APM X-Gene v2 platform.
      arm64: dts: apm: Add DT node for X-Gene v2 SLIMpro Mailbox I2C Driver

 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 19 +++++++++++++++++++
 arch/arm64/boot/dts/apm/apm-storm.dtsi     |  5 +++++
 2 files changed, 24 insertions(+)
