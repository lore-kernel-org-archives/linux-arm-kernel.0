From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Sun, 5 Apr 2015 22:26:15 +0200
Subject: [GIT PULL] at91: clocksource-driver for 4.1 #2
In-Reply-To: <20150403180556.GK23023@localhost>
References: <20150403180556.GK23023@localhost>
Message-ID: <1428265575-11257-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is the patch that was extracted from my previous pull request and that
would go on top of your at91/clocksource-driver branch.

Thanks, best regards,

The following changes since commit 8590ca655a19f9e124b52bfbf28f14eb16a05bec:

  ARM: at91: remove useless include (2015-03-16 17:03:08 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-clocksource-driver2

for you to fetch changes up to 7ab7ef741a467e7af50c9b7446ec992bec9ea6a7:

  clocksource: atmel-st: select MFD_SYSCON (2015-04-05 22:19:50 +0200)

----------------------------------------------------------------
A fix for the ST clocksource driver Kconfig option

----------------------------------------------------------------
Alexandre Belloni (1):
      clocksource: atmel-st: select MFD_SYSCON

 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
Nicolas Ferre
