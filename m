From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Tue, 25 Sep 2018 16:21:26 +0000
Subject: [GIT PULL] STi DT update for v4.20 round 1
Message-ID: <7250e85d-374a-76e7-fa8a-4911ef7a12ae@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof

PLease consider this first round of STi dts update for v4.20

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
tags/sti-dt-for-v4.20-round1

for you to fetch changes up to b5b4c8dd5c44edc112a362f87a8d8953336571bd:

  ARM: dts: stih410: change syntax of multiple DAI (2018-09-25 17:41:51
+0200)

----------------------------------------------------------------
STi DT update:
 _ Change syntax of multiple DAI links

----------------------------------------------------------------
Christophe Priouzeau (1):
      ARM: dts: stih410: change syntax of multiple DAI

 arch/arm/boot/dts/stih410-b2260.dts  |  5 ++++-
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 11 ++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)
