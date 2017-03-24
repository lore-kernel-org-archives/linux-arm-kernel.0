From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 24 Mar 2017 10:58:07 -0700
Subject: [GIT PULL 7/7] Broadcom drivers changes for 4.12
In-Reply-To: <20170324175807.27272-1-f.fainelli@gmail.com>
References: <20170324175807.27272-1-f.fainelli@gmail.com>
Message-ID: <20170324175807.27272-7-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/drivers

for you to fetch changes up to bd0faf08dc7fcb3e555b35f556c9012b3c93de3b:

  soc: bcm: brcmstb: Match additional compatible strings (2017-03-05 17:00:57 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC drivers updates for 4.12,
please pull the following changes:

- Florian updates the Broadcom STB GISB arbiter driver with a bunch of
  compatible strings for MIPS-based STBs found under arch/mips/boot/dts/brcm/ in
  order for the SoC identification driver to recognize these chips

----------------------------------------------------------------
Florian Fainelli (1):
      soc: bcm: brcmstb: Match additional compatible strings

 drivers/soc/bcm/brcmstb/common.c | 9 +++++++++
 1 file changed, 9 insertions(+)
