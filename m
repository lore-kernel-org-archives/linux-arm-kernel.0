From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Mar 2018 09:43:45 -0700
Subject: [GIT PULL 3/3] droid4 defconfig changes for v4.17
In-Reply-To: <pull-1521736966-849602@atomide.com>
References: <pull-1521736966-849602@atomide.com>
Message-ID: <pull-1521736966-849602@atomide.com-3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 740c01f76ab3712a45c2f02233c800829626e9ba:

  ARM: multi_v7_defconfig: Enable USB gadget configfs as loadable module (2018-03-06 11:25:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/defconfig-pt2-signed

for you to fetch changes up to 372bed66bfbbc867c085c655b927a4c7fdb4870c:

  ARM: multi_v7_defconfig: Enable CPCAP related options mostly as loadable modules (2018-03-20 07:10:24 -0700)

----------------------------------------------------------------
Second set of defconfig changes for omap variants for v4.17

This series enables more devices working on droid4 to make it easier
for people and distros to use out of the box.

----------------------------------------------------------------
Tony Lindgren (5):
      ARM: omap2plus_defconfig: Enable PWM_VIBRA
      ARM: omap2plus_defconfig: Add AUDIO_GRAPH_CARD
      ARM: omap2plus_defconfig: Enable MDM6600 USB PHY
      ARM: omap2plus_defconfig: Add UINPUT
      ARM: multi_v7_defconfig: Enable CPCAP related options mostly as loadable modules

 arch/arm/configs/multi_v7_defconfig  | 9 +++++++++
 arch/arm/configs/omap2plus_defconfig | 5 +++++
 2 files changed, 14 insertions(+)
