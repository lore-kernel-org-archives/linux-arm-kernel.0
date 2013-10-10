From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Oct 2013 16:04:36 -0700
Subject: [PATCH 0/2] Minor omap2plus_defconfig updates for v3.13 merge window
Message-ID: <20131010230325.8152.27727.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

As it's currently a bit of a pain to patch omap2plus_defconfig, let's
run make savedefconfig on it as that also gets rid of about 30 lines
from it. And let's add some WLAN modules and support for of_serial.

Regards,

Tony

---

Tony Lindgren (2):
      ARM: OMAP2+: Run make savedefconfig on omap2plus_defconfig to shrink it
      ARM: OMAP2+: Add WLAN modules and of_serial to omap2plus_defconfig


 arch/arm/configs/omap2plus_defconfig |  101 +++++++++++++---------------------
 1 file changed, 39 insertions(+), 62 deletions(-)

-- 
Signature
