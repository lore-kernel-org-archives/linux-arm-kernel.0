From: khilman@ti.com (Kevin Hilman)
Date: Wed, 24 Aug 2011 16:43:56 -0700
Subject: [PATCH 0/1] PM: omap_device fix for v3.1-rc
Message-ID: <1314229437-31836-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While this fix could go via the OMAP tree, since the original patch
causing the problem went via Rafael's tree (due to dependencies) I'm
submitting the fix to go via Rafael's tree as well.

Applies on v3.1-rc3.

Kevin Hilman (1):
  OMAP: omap_device: only override _noirq methods, not normal
    suspend/resume

 arch/arm/plat-omap/omap_device.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

-- 
1.7.6
