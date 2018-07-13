From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 13 Jul 2018 07:38:21 -0700
Subject: [GIT PULL 6/6 v2] Broadcom soc changes for 4.19
In-Reply-To: <20180713143821.1514-1-f.fainelli@gmail.com>
References: <20180713143821.1514-1-f.fainelli@gmail.com>
Message-ID: <20180713143821.1514-6-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.19/soc

for you to fetch changes up to f3f49e42c119f6fc7cd06ddae495915cf9f65654:

  ARM: debug: fix BCM2836 order entry (2018-06-18 09:30:14 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs platform changes for
4.19, please pull the following:

- Clement re-orders the UART debug entries to be in ascending order and
  he also adds the iProc UART3 debug address since that is a common
  location for iProc based designs.

----------------------------------------------------------------
Cl?ment Peron (2):
      ARM: debug: Add iProc UART3 debug addresses
      ARM: debug: fix BCM2836 order entry

 arch/arm/Kconfig.debug | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
