From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 29 Jan 2015 12:40:23 -0800
Subject: [GIT PULL]  Broadcom MAINTAINERS file updates for 3.20 (v3)
Message-ID: <1422564023-28977-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-3.20/maintainer

for you to fetch changes up to 5e2aed2746a02f677cc07679407360ab80b4106a:

  MAINTAINERS: add a git entry for BMIPS-based BCM7xxx SoCs (2015-01-29 12:31:30 -0800)

Arnd, Olof, please drop the previous pull request and use this one instead, thanks!

Changes in v3:
- provide working git repositories links

Changes in v2:
- consistently use github.com/broadcom (lower case) everywhere

----------------------------------------------------------------
This pull request contains updates to our MAINTAINERS files for all relevant
Broadcom SoCs: BCM63xx, Cygnus/iProc, ARM & MIPS-based BCM7xxx (brcmstb).

Our new code location for all Broadcom-related kernel activities is now on
http://github.com/broadcom/.

----------------------------------------------------------------
Florian Fainelli (4):
      MAINTAINERS: move BCM63xx ARM-based SoCs git tree
      MAINTAINERS: update Broadcom Cygnus SoC git tree
      MAINTAINERS: add a git entry for BCM7xxx ARM-based SoCs
      MAINTAINERS: add a git entry for BMIPS-based BCM7xxx SoCs

 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
