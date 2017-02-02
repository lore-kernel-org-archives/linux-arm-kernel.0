From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  2 Feb 2017 10:47:42 +0100
Subject: [PATCH 0/2] drm: meson: Fixup driver and module name 
Message-ID: <1486028864-19622-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is a simple fixup to rename the confusion possible
module and driver name "meson" to a more explicit "meson-drm" name.

Neil Armstrong (2):
  drm: meson: rename module name to meson-drm
  drm: meson: rename driver name to meson-drm

 drivers/gpu/drm/meson/Makefile    | 6 +++---
 drivers/gpu/drm/meson/meson_drv.c | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
1.9.1
