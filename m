From: manabian@gmail.com (Joachim Eastwood)
Date: Fri,  4 Mar 2016 23:32:59 +0100
Subject: [GIT PULL] LPC18xx DTS changes for v4.6
Message-ID: <1457130779-10865-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc team,

Please consider pulling these DTS changes for the NXP LPC18xx
platform into arm-soc/dt.

Contain DTS nodes for the CREG clock controller and the RTC.

Sorry for the late pull request. I wasn't really planning to send
anything this round, but since the creg-clk driver just went into
clk-next I decided to do so afer all. None of this stuff is any
critical so feel free to ignore this pull request if you consider
it too late.

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://github.com/manabian/linux-lpc.git tags/lpc18xx_dts_for_4.6

for you to fetch changes up to b2bbbbb217847241be38c870c39f80287ea56a14:

  ARM: dts: lpc18xx: add rtc node (2016-03-04 23:00:51 +0100)

----------------------------------------------------------------
Device Tree additions for LPC18xx platform
 - CREG clock controller
 - Real Time Clock (RTC)

With the CREG clock controller in place it is now possible
to enable the internal RTC on LPC18xx/43xx.

----------------------------------------------------------------
Joachim Eastwood (3):
      ARM: dts: lpc18xx: remove unit addresses from creg childs
      ARM: dts: lpc18xx: add creg-clk node
      ARM: dts: lpc18xx: add rtc node

 arch/arm/boot/dts/lpc18xx.dtsi | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)
