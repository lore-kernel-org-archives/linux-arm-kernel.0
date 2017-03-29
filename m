From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 29 Mar 2017 14:41:01 -0700
Subject: [GIT PULL] Amlogic driver updates for v4.12:
Message-ID: <m2lgrn69si.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Below are some driver changes for Amlogic platforms for v4.12, with acks
from the appropriate maintainers included.

Kevin


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-drivers

for you to fetch changes up to 7a9bc330df9b8fb3245d50a198b5c6d4d634b06f:

  firmware: meson-sm: Allow 0 as valid return value (2017-03-23 12:22:40 -0700)

----------------------------------------------------------------
Amlogic driver updates for v4.12:
- firmware: updates/fixes for meson-sm

----------------------------------------------------------------
Carlo Caione (2):
      firmware: meson-sm: Check for buffer output size
      firmware: meson-sm: Allow 0 as valid return value

 drivers/firmware/meson/meson_sm.c       | 20 ++++++++++++++++----
 drivers/nvmem/meson-efuse.c             |  2 +-
 include/linux/firmware/meson/meson_sm.h |  4 ++--
 3 files changed, 19 insertions(+), 7 deletions(-)
