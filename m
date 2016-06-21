From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 21 Jun 2016 14:26:35 +0200
Subject: [PULL] drm: atmel-hlcdc: Fixes for 4.7-rc5
Message-ID: <20160621142635.43c79952@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Here is a PR containing two fixes for 4.7.

Regards,

Boris

The following changes since commit 58a2ab3af722550b2e4e8155eb08660e16c20ee6:

  drm: atmel-hlcdc: fix a NULL check (2016-06-01 15:59:36 +0200)

are available in the git repository at:

  git at github.com:bbrezillon/linux-at91.git tags/drm-atmel-hlcdc-fixes/for-4.7-rc5

for you to fetch changes up to 0b1e1eb76220afa043b2733dfe61f5927cf0e458:

  drm: atmel-hlcdc: Fix OF graph parsing (2016-06-21 14:15:45 +0200)

----------------------------------------------------------------
Two bug fixes for the atmel-hlcdc driver.

----------------------------------------------------------------
Boris Brezillon (2):
      drm: atmel-hlcdc: actually disable scaling when no scaling is required
      drm: atmel-hlcdc: Fix OF graph parsing

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 10 ++++++----
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c  |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)
	
