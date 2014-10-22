From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 22 Oct 2014 19:01:27 +0200
Subject: [GIT PULL] at91: fixes for 3.18 #1
Message-ID: <1413997287-9855-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is my first batch of fixes for 3.18.
The power/reset driver part is there because it was introduced through arm-soc
and it seems that it's better to continue like that.
The MAINTAINERS entry is better if included the soonest.

Note as well that it's my first pull-request from my newly created kernel.org
account: I hope that everything is done properly ;-)

Thanks, bye,

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes

for you to fetch changes up to 106c67af2fb938880edbf43b49dabbd8d2534839:

  ARM: at91/dt: sam9263: fix PLLB frequencies (2014-10-22 10:08:22 +0200)

----------------------------------------------------------------
First AT91 fixes for 3.18:
- one more MAINTAINERS entry for the SSC driver
- a fix for the newly introduced power/reset driver
- a fix on at91sam9263 USB due to PLLB misconfiguration

----------------------------------------------------------------
Alexandre Belloni (1):
      power: reset: at91-reset: fix power down register

Bo Shen (1):
      MAINTAINERS: add atmel ssc driver maintainer entry

Boris Brezillon (1):
      ARM: at91/dt: sam9263: fix PLLB frequencies

 MAINTAINERS                        | 7 +++++++
 arch/arm/boot/dts/at91sam9263.dtsi | 5 +++--
 drivers/power/reset/at91-reset.c   | 4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
Nicolas Ferre
