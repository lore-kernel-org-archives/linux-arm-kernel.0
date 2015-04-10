From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 10 Apr 2015 12:00:22 -0700
Subject: [GIT PULL] MAINTAINERS update for Broadcom SoCs for 4.1
Message-ID: <1428692422-18369-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f22e6e847115abc3a0e2ad7bb18d243d42275af1:

  Linux 4.0-rc7 (2015-04-06 15:39:45 -0700)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.1/maintainers

for you to fetch changes up to 90a604a9ce881290fdc7468df4ca4e9c2ae4de62:

  MAINTAINERS: Update brcmstb entry (2015-04-10 11:52:40 -0700)

----------------------------------------------------------------
This pull request contains 3 changes to the MAINTAINERS file for Broadcom SoCs:

- add Ray and Scott for mach-bcm
- remove Christian for mach-bcm
- remove Marc for brcmstb

----------------------------------------------------------------
Florian Fainelli (3):
      MAINTAINERS: Update mach-bcm maintainers list
      MAINTAINERS: Remove Christian Daudt for mach-bcm
      MAINTAINERS: Update brcmstb entry

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index efbcb50e4969..ba694bfa0a4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2117,8 +2117,9 @@ S:	Supported
 F:	drivers/net/ethernet/broadcom/bnx2x/
 
 BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITECTURE
-M:	Christian Daudt <bcm@fixthebug.org>
 M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Ray Jui <rjui@broadcom.com>
+M:	Scott Branden <sbranden@broadcom.com>
 L:	bcm-kernel-feedback-list at broadcom.com
 T:	git git://github.com/broadcom/mach-bcm
 S:	Maintained
@@ -2169,7 +2170,6 @@ S:	Maintained
 F:	drivers/usb/gadget/udc/bcm63xx_udc.*
 
 BROADCOM BCM7XXX ARM ARCHITECTURE
-M:	Marc Carino <marc.ceeeee@gmail.com>
 M:	Brian Norris <computersforpeace@gmail.com>
 M:	Gregory Fong <gregory.0xf0@gmail.com>
 M:	Florian Fainelli <f.fainelli@gmail.com>
