From: peda@axentia.se (Peter Rosin)
Date: Fri, 24 Aug 2018 10:54:59 +0200
Subject: [PATCH 0/2] drm/atmel-hlcdc: revise selection of pixel-clock
 frequency divider
Message-ID: <20180824085501.9740-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Some background can be found here:
https://lists.freedesktop.org/archives/dri-devel/2018-August/187182.html

The "10 times" discriminator in patch 2/2 can certainly be discussed...

Cheers,
Peter

Peter Rosin (2):
  drm/atmel-hlcdc: prefer a higher rate clock as pixel-clock base
  drm/atmel-hlcdc: allow selecting a higher pixel-clock that requested

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 29 ++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

-- 
2.11.0
