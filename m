From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  6 Jul 2016 20:36:14 -0700
Subject: [GIT PULL 2/4] Broadcom ARM-based SoC changes for 4.8 (part 2)
In-Reply-To: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
References: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1467862574-6522-5-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 423779cfd3ca73b9236e6eb798477f3a4f13355d:

  ARM: bcm: fix missing include of kona_l2_cache.h (2016-06-08 10:17:15 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/soc-part2

for you to fetch changes up to 2dc9e0b9f162af7e2047176a31716eac5301916f:

  ARM: debug: Enable DEBUG_BCM_5301X for Northstar Plus SoCs (2016-07-06 19:43:22 -0700)

----------------------------------------------------------------
This pull request contains the second part of the Broadcom ARM-based SoC changes:

- Florian updates the DEBUG_UART_BCM5301X entry to cover both NS and NSP SoCs
  since they both have the same location

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: debug: Enable DEBUG_BCM_5301X for Northstar Plus SoCs

 arch/arm/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
