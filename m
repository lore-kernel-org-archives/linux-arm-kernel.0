From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 2 Jan 2015 17:08:18 +0100
Subject: [GIT PULL] Fixes for 3.19, #2
Message-ID: <20150102160818.GB6708@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

Here is a second set of fixes for the next -rc. It contains a single
patch to fix an Opps with the kirkwood netbig LED driver. This patch
has been sent to the LED maintainers a couple of times, with
reminders, but there has been no response. So we would like to take it
via mvebu->arm-soc. We informed the LED maintainers about this plan,
and they are Cc: to this pull request, just so everybody knows what is
going on.

Thanks
	Andrew

The following changes since commit d4b0833a65e8b9fc58d992ba0cc89cad1580db31:

  ARM: mvebu: Fix pinctrl configuration for Armada 370 DB (2014-12-21 06:01:05 -0600)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.19-2

for you to fetch changes up to bb682e44c77731711818c2cf9f6d4bc277207eee:

  leds: netxbig: fix oops at probe time (2014-12-30 10:39:23 -0600)

----------------------------------------------------------------
2nd set of fixes for 3.19:

leds: netxbig: fix oops at probe time

----------------------------------------------------------------
Simon Guinot (1):
      leds: netxbig: fix oops at probe time

 drivers/leds/leds-netxbig.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
