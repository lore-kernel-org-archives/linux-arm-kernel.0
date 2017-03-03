From: carlo@caione.org (Carlo Caione)
Date: Fri,  3 Mar 2017 16:17:57 +0100
Subject: [PATCH 0/2] meson-sm: Fix issues when reading data from sm
Message-ID: <20170303151759.8330-1-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

While working on a related driver I noticed a couple of problems in the
meson-sm driver. The problems are unrelated but since the fixes touch the same
codebase I decided to submit these in the same patchset.

Carlo Caione (2):
  firmware: meson-sm: Check for buffer output size
  firmware: meson-sm: Allow 0 as valid return value

 drivers/firmware/meson/meson_sm.c       | 20 ++++++++++++++++----
 drivers/nvmem/meson-efuse.c             |  2 +-
 include/linux/firmware/meson/meson_sm.h |  4 ++--
 3 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.12.0
