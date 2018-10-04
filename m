From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 4 Oct 2018 20:48:19 +0530
Subject: [GIT PULL] DaVinci DT support for v4.20
Message-ID: <2b3c8d80-578c-45f6-b111-ca98222cc290@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.20/dt

for you to fetch changes up to aea4762fb46e048c059ff49565ee33da07c8aeb3:

  ARM: dts: da850-lego-ev3: slow down A/DC as much as possible (2018-10-04 20:08:40 +0530)

----------------------------------------------------------------
DaVinci DT updates for v4.20
----------------------------
- A non-critical fix to reduce errors on A/DC on Lego Mindstorms EV3
- Support for GPIO expander on DA850 EVM

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: da850-evm: Enable tca6416 on baseboard

David Lechner (1):
      ARM: dts: da850-lego-ev3: slow down A/DC as much as possible

 arch/arm/boot/dts/da850-evm.dts      | 6 ++++++
 arch/arm/boot/dts/da850-lego-ev3.dts | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)
