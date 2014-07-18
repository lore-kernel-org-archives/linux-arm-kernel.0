From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Jul 2014 16:12:10 +0200
Subject: [GIT PULL] at91: fixes for 3.16 #2
Message-ID: <1405692730-31284-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is the latest regressions that we found while testing the at91sam9n12 and
at91sam9x5 platforms following our move to CCF.
I created a pull-request this time because I have 3 patches: there should be
no conflict anyway. This tag does not contain the fix that Olof had taken during
previous -rc cycle on purpose: this way it won't appear twice in the history.

Thanks, best regards,

The following changes since commit 971dc9ce106110745f246337f229013589354536:

  ARM: at91/dt: sam9261: remove slow RC osc (2014-06-25 18:00:17 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to e0d69e119fc6bf7cc3c9f791478108c1b925bb2e:

  ARM: at91/dt: add missing clocks property to pwm node in sam9x5.dtsi (2014-07-18 15:56:35 +0200)

----------------------------------------------------------------
Second AT91 fixes series for 3.16
- fix clock definitions after the move to CCF for:
  - at91sam9n12 (ohci)
  - at91sam9x5 (ohci, pwm)

----------------------------------------------------------------
Bo Shen (1):
      ARM: at91: at91sam9x5: correct typo error for ohci clock

Boris BREZILLON (2):
      ARM: at91/dt: fix usb0 clocks definition in sam9n12 dtsi
      ARM: at91/dt: add missing clocks property to pwm node in sam9x5.dtsi

 arch/arm/boot/dts/at91sam9n12.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Nicolas Ferre
