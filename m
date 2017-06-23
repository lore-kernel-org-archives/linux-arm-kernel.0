From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 23 Jun 2017 19:25:53 +0200
Subject: [GIT PULL] ARM: actions: dt64 for v4.13
In-Reply-To: <20170623172556.12618-1-afaerber@suse.de>
References: <20170623172556.12618-1-afaerber@suse.de>
Message-ID: <20170623172556.12618-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

This is the initial dt64 pull for Actions Semi.
The Kconfig symbol is introduced in the arm64 pull.

Regards,
Andreas

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm64-dt-for-4.13

for you to fetch changes up to 06edb80f8c79f457983c9af93c1364fc1077c190:

  arm64: dts: Add Actions Semi S900 and Bubblegum-96 (2017-06-19 00:33:22 +0200)

----------------------------------------------------------------
Actions Semi ARM64 based SoC DT for 4.13

This adds an initial DT for the S900 SoC and a devboard based on it.

----------------------------------------------------------------
Andreas F?rber (2):
      dt-bindings: Add vendor prefix for uCRobotics
      arm64: dts: Add Actions Semi S900 and Bubblegum-96

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/actions/Makefile               |   5 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  |  35 +++++
 arch/arm64/boot/dts/actions/s900.dtsi              | 164 +++++++++++++++++++++
 5 files changed, 206 insertions(+)
 create mode 100644 arch/arm64/boot/dts/actions/Makefile
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
 create mode 100644 arch/arm64/boot/dts/actions/s900.dtsi
