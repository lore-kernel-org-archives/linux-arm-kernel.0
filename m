From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu,  1 Mar 2018 20:18:44 +0100
Subject: [PATCH 0/2] drm/sun4i: backend: Support interleaved YUV planes
Message-ID: <cover.f0cb3210f2d878853ef16506da152f38ba2e3286.1519931807.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is an attempt at supporting the interleaved YUV planes in the sun4i
DRM driver for SoCs that use the DE1.

There's nothing out of the extraordinary there, we just have one more
constraint in our DRM driver, since we can only have a single YUV plane.

Let me know what you think,
Maxime

Maxime Ripard (2):
  drm/sun4i: backend: Check that we only have a single YUV plane
  drm/sun4i: backend: Support YUV planes

 drivers/gpu/drm/sun4i/sun4i_backend.c | 128 ++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.h |  18 ++++-
 drivers/gpu/drm/sun4i/sun4i_layer.c   |   4 +-
 3 files changed, 148 insertions(+), 2 deletions(-)

base-commit: 35152d1159dbb0277b18ae664dfb5b11c27fdefa
-- 
git-series 0.9.1
