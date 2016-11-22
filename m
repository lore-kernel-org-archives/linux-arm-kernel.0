From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 21 Nov 2016 21:48:19 -0800
Subject: [GIT PULL 1/6] Broadcom soc changes for 4.10
Message-ID: <20161122054824.16974-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.10/soc

for you to fetch changes up to 09f3510fb70a46c8921f2cf4a90dbcae460a6820:

  ARM: BCM5301X: Add back handler ignoring external imprecise aborts (2016-11-16 12:39:05 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC changes for 4.10, please pull
the following:

- Rafal adds back the abort handler hook on BCM5301x which is required to silence
  errors forwared from the PCIe controller that cannot be silenced at the PCIe RC level

----------------------------------------------------------------
Rafa? Mi?ecki (1):
      ARM: BCM5301X: Add back handler ignoring external imprecise aborts

 arch/arm/mach-bcm/bcm_5301x.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
