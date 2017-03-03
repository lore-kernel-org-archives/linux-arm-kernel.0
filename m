From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  3 Mar 2017 11:14:26 +0100
Subject: [RFC PATCH 0/2] drm/meson: RST Documentation
Message-ID: <1488536068-9407-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be aligned with the other DRM drivers, this patchset converts the
actual drivers documentation to RST format, adds a top RTS meson file
and adds an entry in the gpu/index.rst file.

This patchser depends on the HDMI patchset at [1]

Sample output can be found at [2]

[2] http://people.freedesktop.org/~narmstrong/meson_drm_doc/gpu/meson.html
[1] http://lkml.kernel.org/r/1488469207-523-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (2):
  drm/meson: Convert existing documentation to actual kerneldoc
  drm/meson: Add RST to bring together kerneldoc

 Documentation/gpu/index.rst           |  1 +
 Documentation/gpu/meson.rst           | 61 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/meson/meson_canvas.c  |  4 ++-
 drivers/gpu/drm/meson/meson_drv.c     |  5 +--
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 25 +++++++++-----
 drivers/gpu/drm/meson/meson_vclk.c    | 22 +++++++++----
 drivers/gpu/drm/meson/meson_venc.c    | 25 ++++++++------
 drivers/gpu/drm/meson/meson_viu.c     |  6 +++-
 drivers/gpu/drm/meson/meson_vpp.c     |  8 +++--
 9 files changed, 127 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/gpu/meson.rst

-- 
1.9.1
