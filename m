From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 6 Sep 2016 14:58:29 +0200
Subject: [PULL] drm/atmel-hlcdc: fixes for 4.8-rc6
Message-ID: <20160906145829.528ebfc9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Here are two fixes for 4.8-rc6. I was supposed to send this PR just
after -rc1, but I completely forgot, so if you feel it's too late
for this release, I can queue them for 4.9 (note that the fixes are
trivial, and I don't think they can introduce a regression).

Regards,

Boris

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git at github.com:bbrezillon/linux-at91.git tags/drm/atmel-hlcdc/4.8-fixes

for you to fetch changes up to 1ba7db07ccc2825669d6e376632316813a072887:

  drm/atmel-hlcdc: Make ->reset() implementation static (2016-09-06 14:46:16 +0200)

----------------------------------------------------------------
Two fixes for 4.8:
- missing static specifier on atmel_hlcdc_crtc_reset()
- bug in the hardware scaling logic

----------------------------------------------------------------
Jan Leupold (1):
      drm: atmel-hlcdc: Fix vertical scaling

Thierry Reding (1):
      drm/atmel-hlcdc: Make ->reset() implementation static

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c  |  2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)
