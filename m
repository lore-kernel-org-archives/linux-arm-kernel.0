From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 29 Dec 2014 22:10:47 +0100
Subject: [GIT PULL] mvebu: Fixes for -rc3
Message-ID: <20141229211047.GA18826@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks

Jason is taking a back seat this cycle and i'm doing all the patch
wrangling for mvebu.

Here is a pull request for fixes for 3.19. Just one patch.

Please let me know if i've done anything wrong.

       Andrew

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  ssh://git.infradead.org/srv/git/linux-mvebu.git tags/mvebu-fixes-3.19

for you to fetch changes up to d4b0833a65e8b9fc58d992ba0cc89cad1580db31:

  ARM: mvebu: Fix pinctrl configuration for Armada 370 DB (2014-12-21 06:01:05 -0600)

----------------------------------------------------------------
Fixes for 3.19

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: mvebu: Fix pinctrl configuration for Armada 370 DB

 arch/arm/boot/dts/armada-370-db.dts | 24 ------------------------
 1 file changed, 24 deletions(-)
