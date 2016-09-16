From: patrice.chotard@st.com (Patrice Chotard)
Date: Fri, 16 Sep 2016 09:55:01 +0200
Subject: [GIT PULL] STi DT update for v4.9, round 3
Message-ID: <e51819f2-a354-7153-3b86-a92e99b85213@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof

PLease consider this next batch for v4.9, dedicated for clock improvements

The following changes since commit 443fd7c92f5a000796b02683157d17b2575450e1:

  ARM: DT: STi: stihxxx-b2120: Add DT nodes for STi audio card (2016-09-14 13:37:29 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-dt-for-v4.9-3

for you to fetch changes up to 3a74152ce62e7ec1b8a5604b10e40d2a66d8f43b:

  ARM: dts: STiH410: clock configuration to address 720p and 1080p (2016-09-16 09:42:13 +0200)

----------------------------------------------------------------

Clock improvement for video playback

This serie allows to increase video resolutions and make audio
adjustment during a video playback for STiH407 family socs.

----------------------------------------------------------------
Gabriel Fernandez (9):
      ARM: dts: STiH4xx: Simplify clock binding of STiH4xx platforms
      ARM: dts: STiH407: Enable clock propagation for audio clocks
      ARM: dts: STiH410: Enable clock propagation for audio clocks
      ARM: dts: STiH418: Enable clock propagation for audio clocks
      ARM: dts: STiH407: Enable synchronous clock mode for video clocks
      ARM: dts: STiH410: Enable synchronous clock mode for video clocks
      ARM: dts: STiH418: Enable synchronous clock mode for video clocks
      ARM: dts: STi: STiH407: clock configuration to address 720p and 1080p
      ARM: dts: STiH410: clock configuration to address 720p and 1080p

 arch/arm/boot/dts/stih407-clock.dtsi | 22 +++++++++++-----------
 arch/arm/boot/dts/stih407.dtsi       | 16 +++++++++++++---
 arch/arm/boot/dts/stih410-clock.dtsi | 20 ++++++++++----------
 arch/arm/boot/dts/stih410.dtsi       | 16 +++++++++++++---
 arch/arm/boot/dts/stih418-clock.dtsi | 20 ++++++++++----------
 5 files changed, 57 insertions(+), 37 deletions(-)
