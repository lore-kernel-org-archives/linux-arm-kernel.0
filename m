From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 4 Dec 2014 17:38:02 +0100
Subject: [GIT PULL] at91: defconfig for 3.19 #1 (bis)
In-Reply-To: <3905790.gg6cCb9BU6@wuerfel>
References: <3905790.gg6cCb9BU6@wuerfel>
Message-ID: <1417711082-27680-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is the updated version of the 3.19 defconfig pull-request. It is now based
on 3.18-rc1 per Arnd's request.

Here is a pull-request for updating the AT91 defconfig files. Note that we only
have two now that the per-SoC defconfigs are gone.

Thanks, bye,

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-defconfig

for you to fetch changes up to 51756cbd407b760858a16341eb37ee527be178fd:

  ARM: at91/defconfig: add DM9000 to at91_dt (2014-12-04 17:32:01 +0100)

----------------------------------------------------------------
First batch of defconfigs for AT91 / 3.19:
- use NEON for all C-A5, neon code handles the !NEON case
- add new XDMA driver
- add some useful drivers as we only have a single defconfig for all
  AT91SAM9/RM9200

----------------------------------------------------------------
Ludovic Desroches (1):
      ARM: at91: sama5: update defconfig

Nicolas Ferre (4):
      ARM: at91/defconfig: add the XDMA driver
      ARM: at91/defconfig: add TCB PWM driver selection
      ARM: at91/defconfig: add QT1070 to at91_dt
      ARM: at91/defconfig: add DM9000 to at91_dt

 arch/arm/configs/at91_dt_defconfig | 3 +++
 arch/arm/configs/sama5_defconfig   | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
Nicolas Ferre
