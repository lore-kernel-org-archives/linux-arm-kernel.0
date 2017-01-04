From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  4 Jan 2017 10:55:50 +0100
Subject: [PATCH 0/2] drm/meson: Fix CVBS initialization
Message-ID: <1483523752-14705-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie fixes the CVBS initialization when HDMI is already configured
by the bootloader and fixes the CVBS vdac disable register values.

Neil Armstrong (2):
  drm/meson: Fix CVBS initialization when HDMI is configured by
    bootloader
  drm/meson: Fix CVBS VDAC disable

 drivers/gpu/drm/meson/meson_venc.c      | 19 +++++++++++++++++++
 drivers/gpu/drm/meson/meson_venc_cvbs.c |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
1.9.1
