From: peda@axentia.se (Peter Rosin)
Date: Fri, 24 Aug 2018 11:24:56 +0200
Subject: [PATCH v2 0/2] drm/atmel-hlcdc: revise selection of pixel-clock
 frequency divider
Message-ID: <20180824092458.13165-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Some background can be found here:
https://lists.freedesktop.org/archives/dri-devel/2018-August/187182.html

The "10 times" discriminator in patch 2/2 can certainly be discussed...

Cheers,
Peter

Changes since v1    https://lkml.org/lkml/2018/8/24/187

- added {} to an if body for symmetry
- reformatted comments a little bit
- spelling/grammar fixes

Peter Rosin (2):
  drm/atmel-hlcdc: prefer a higher rate clock as pixel-clock base
  drm/atmel-hlcdc: allow selecting a higher pixel-clock than requested

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 30 ++++++++++++++++++++------
 1 file changed, 23 insertions(+), 7 deletions(-)

-- 
2.11.0
