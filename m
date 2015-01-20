From: arun.ramamurthy@broadcom.com (arun.ramamurthy at broadcom.com)
Date: Mon, 19 Jan 2015 16:05:28 -0800
Subject: [PATCHv3 0/2] Added Multiple Phy support for ehci and ohci drivers
Message-ID: <1421712330-11089-1-git-send-email-arun.ramamurthy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>

Broadcom has a chip where one ehci and ohci controller are connected
to three separate phys. This patch allows each phy to be controlled
separately.

Changes in v2:
- removed x character mistakenly introduced by manual edit of diff file 

Changes in v3:
- Addressed Alan Stern's commnents on support for non-dt cases

Arun Ramamurthy (1):
  usb: ehci-platform: add support for multiple phys per controller

 drivers/usb/host/ehci-platform.c | 82 +++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 22 deletions(-)

-- 
2.2.2
