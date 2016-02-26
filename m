From: dhdang@apm.com (Duc Dang)
Date: Thu, 25 Feb 2016 18:51:58 -0800
Subject: [GIT PULL 1/2] arm64: X-Gene platforms DTS changes queued for v4.6 -
 part1
Message-ID: <CADaLND=vwMXG5EcWpnKYODABcXkToiW_kF6s_disLmUknZx_Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the first part of DT changes on X-Gene platforms for v4.6 with
below information:

+ "arm64: dts: apm: Update Merlin DT PCP PLL clock node for v2
hardware" is the 3rd patch of the series
http://www.spinics.net/lists/arm-kernel/msg475481.html, which was also
accepted.

+ "arm64: dts: apm: Update X-Gene standby GPIO controller DTS entries"
is the 3rd patch of the series
http://www.spinics.net/lists/arm-kernel/msg483918.html, which was
already accepted.
The 3 remaining patches are the follow up of the same "Enable X-Gene
standby GPIO as  interrupt controller" series to update standby GPIO
controller for X-Gene v2 and power button GPIO on both X-Gene v1 and
v2 platforms

Regards,
Duc Dang.
------

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.6-part1

for you to fetch changes up to edf21f271024ec6adb93c7b4e6c1dc928b6a7250:

  arm64: dts: apm: Update GPIO to control power-off on X-Gene v2
platforms (2016-02-25 17:14:00 -0800)

----------------------------------------------------------------
First part of X-Gene DT changes queued for v4.6

This patch set includes:
+ A change in compatible string of X-Gene v2 SoC
PLL DT node to reflect the v2 hardware
+ Update DT fields for X-Gene v1 and v2 standby
GPIO controllers
+ Update declaration of power button GPIO for
X-Gene v1 and X-Gene v2 platforms

----------------------------------------------------------------
Duc Dang (3):
      arm64: dts: apm: Update GPIO to control power-off on X-Gene v1 platforms
      arm64: dts: apm: Update GPIO standby controller DT node for
X-Gene v2 platforms
      arm64: dts: apm: Update GPIO to control power-off on X-Gene v2 platforms

Loc Ho (1):
      arm64: dts: apm: Update Merlin DT PCP PLL clock node for v2 hardware

Quan Nguyen (1):
      arm64: dts: apm: Update X-Gene standby GPIO controller DTS entries

 arch/arm64/boot/dts/apm/apm-merlin.dts     | 3 ++-
 arch/arm64/boot/dts/apm/apm-mustang.dts    | 3 ++-
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 8 +++++++-
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 3 +++
 4 files changed, 14 insertions(+), 3 deletions(-)
