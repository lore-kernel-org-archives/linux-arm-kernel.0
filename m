From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun,  6 Dec 2015 11:37:10 +0100
Subject: [GIT PULL 1/3] ARM64: berlin: DT changes for v4.5 (round 1)
Message-ID: <1449398232-13699-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is the first round of Marvell Berlin64 DT changes for v4.5.
We have improving BG4CT support with added pinctrl, watchdog, PSCI,
and cpuidle support.

Please pull.

Sebastian

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin64-dt-for-4.5-1

for you to fetch changes up to 1544f99c0ac08376c0a3888aef7722d9f678020c:

  arm64: dts: berlin4ct: support cpuidle-dt (2015-12-06 10:25:28 +0100)

----------------------------------------------------------------
Marvell Berlin64 DT changes (round 1):
- add pinctrl nodes and uart0 pinmux
- add watchdog nodes
- add PSCI-1.0 support
- add cpuidle support

----------------------------------------------------------------
Jisheng Zhang (5):
      arm64: dts: berlin4ct: add the pinctrl node
      arm64: dts: berlin4ct: add default pinmux for uart0
      arm64: dts: berlin4ct: add watchdog nodes
      arm64: dts: berlin: PSCI-1.0 support
      arm64: dts: berlin4ct: support cpuidle-dt

 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 63 +++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)
