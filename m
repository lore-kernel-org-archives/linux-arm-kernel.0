From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Jan 2011 08:43:29 +0200
Subject: [RESEND PATCH 0/3] ARM IRQ patches
Message-ID: <1295505812-5062-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I'm resending these patches as they were not taken previously.

If you want me to wait until closer to next merge window, let
me know and I'll re-send when we get to -rc4.

Felipe Balbi (3):
  arm: Kconfig: remove duplicated GENERIC_HARDIRQS entry
  arm: Kconfig: remove duplicated SPARSE_IRQ entry
  arm: Kconfig: allow OMAP to use sparse IRQ numbering

 arch/arm/Kconfig |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.7.4.rc2
