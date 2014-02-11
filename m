From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 11 Feb 2014 20:43:58 +0100
Subject: [PATCH 0/3] arm: at91: update defconfigs
Message-ID: <1392147841-7815-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few at91 defconfigs where not updated in a long time, refresh the configs for
at91sam9rl and at91sam9260/at91sam9g20.

Alexandre Belloni (3):
  arm: at91sam9rl: refresh defconfig
  arm: at91sam9260_9g20: remove useless configuration
  arm: at91sam9260_9g20: refresh configuration

 arch/arm/configs/at91sam9260_9g20_defconfig |  9 ++-------
 arch/arm/configs/at91sam9rl_defconfig       | 10 +++++++---
 2 files changed, 9 insertions(+), 10 deletions(-)

-- 
1.8.3.2
