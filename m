From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 13 May 2017 20:35:26 -0700
Subject: [GIT PULL 2/2] Broadcom drivers changes for 4.12
In-Reply-To: <20170514033526.21260-1-f.fainelli@gmail.com>
References: <20170514033526.21260-1-f.fainelli@gmail.com>
Message-ID: <20170514033526.21260-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/drivers-fixes

for you to fetch changes up to 31d848aa1d85530770f0bdf1b61a042335d340ad:

  soc: bcm: brcmstb: Correctly match 7435 SoC (2017-05-13 20:27:33 -0700)

----------------------------------------------------------------
This pull request contains Broadcom SoC drivers fixes for 4.12, please
pull the following:

- Florian removes the duplicate compatible string matched by the
  SUN_TOP_CTRL driver and instead uses the correct one for 7435

----------------------------------------------------------------
Florian Fainelli (1):
      soc: bcm: brcmstb: Correctly match 7435 SoC

 drivers/soc/bcm/brcmstb/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
