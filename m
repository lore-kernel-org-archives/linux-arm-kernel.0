From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Mon, 12 Mar 2018 21:15:07 +0100
Subject: [PATCH 0/3] Fix some error handling paths in 'meson_drv_bind_master()'
Message-ID: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1 and 3 are fixes.
Patch 2 is just a kind of clean-up noticed while patching this driver.

If patch 2 is considered as useless, patch 3 can be applied on top of 
patch 1, it does nor depend on the 2nd patch.

Christophe JAILLET (3):
  drm/meson: Fix an un-handled error path in 'meson_drv_bind_master()'
  drm/meson: Use drm_dev_put() instead of drm_dev_unref()
  drm/meson: Fix some error handling paths in 'meson_drv_bind_master()'

 drivers/gpu/drm/meson/meson_drv.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

-- 
2.14.1


---
L'absence de virus dans ce courrier ?lectronique a ?t? v?rifi?e par le logiciel antivirus Avast.
https://www.avast.com/antivirus
