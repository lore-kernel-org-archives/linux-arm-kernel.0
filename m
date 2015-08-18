From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 18 Aug 2015 11:26:55 +0200
Subject: [PULL] drm: atmel-hlcdc: new features for 4.3 or 4.4
Message-ID: <20150818112655.26143418@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dave,

The following PR add support for 3 more atmel SoCs and for some missing
features (new input formats and PRIME support).

As for the other PR I just sent, ideally I would like to get those new
features into 4.3 but since we're already at 4.1-rc7 I'll let you decide
whether this should be queued for the next release or not.

Best Regards,

Boris

The following changes since commit 294947a5c7f6d228b70fcc51a89527e74a38a2c5:

  Merge branch 'vmwgfx-next' of git://people.freedesktop.org/~thomash/linux into drm-next (2015-08-17 16:03:48 +1000)

are available in the git repository at:


  https://github.com/bbrezillon/linux-at91.git drm-atmel-hlcdc-devel

for you to fetch changes up to 5b9fb5e6c6c74666f88f34bd0db183b9c4269d97:

  drm: atmel-hlcdc: add support for sama5d4 SoCs (2015-08-18 11:02:27 +0200)

----------------------------------------------------------------
Boris Brezillon (6):
      drm: atmel-hlcdc: add PRIME support
      drm: atmel-hlcdc: add the missing DRM_ATOMIC flag
      drm: atmel-hlcdc: add RGB565 and RGB444 output support
      drm: atmel-hlcdc: add support for at91sam9x5 SoCs
      drm: atmel-hlcdc: add support for at91sam9n12 SoC
      drm: atmel-hlcdc: add support for sama5d4 SoCs

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c     | 216 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c |   4 ++++
 2 files changed, 219 insertions(+), 1 deletion(-)
