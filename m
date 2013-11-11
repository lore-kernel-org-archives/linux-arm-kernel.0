From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Nov 2013 09:25:37 +0000
Subject: [GIT PULL] [Final] MFD patches due for v3.13
In-Reply-To: <20131023153510.GF2620@lee--X1>
References: <20131023153510.GF2620@lee--X1>
Message-ID: <20131111092537.GA22184@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sam,

Last one for v3.13.

The following changes since commit 6bfd1e63de34a278d67db32e3644340838308252:

  mfd: lpc_sch: Ignore resource conflicts when adding mfd cells (2013-10-23 16:22:40 +0100)

are available in the git repository at:

  git://git.linaro.org/people/ljones/mfd.git tags/mfd-lee-3.13-2

for you to fetch changes up to 883149b624f19ad78b84ab4403c5a32c37c033b2:

  Documentation: mfd: Update s2mps11.txt (2013-11-11 09:09:06 +0000)

----------------------------------------------------------------
mfd-lee-3.13-2

MFD patches due for v3.13.
----------------------------------------------------------------
Charles Keepax (3):
      extcon: arizona: Add defines for microphone detection levels
      extcon: arizona: Fix reset of HPDET after race with removal
      mfd: wm5110: Enable micd clamp functionality

Dan Carpenter (1):
      mfd: pm8921: Potential NULL dereference in pm8921_remove()

Geert Uytterhoeven (2):
      mfd: Stop setting refcounting pointers in original mfd_cell arrays
      mfd: Fix memory leak in mfd_add_devices()

Sachin Kamat (1):
      Documentation: mfd: Update s2mps11.txt

 Documentation/devicetree/bindings/mfd/s2mps11.txt | 13 +++++++------
 drivers/extcon/extcon-arizona.c                   | 31 +++++++++++++++++++++++++------
 drivers/mfd/mfd-core.c                            | 29 +++++++++++++++++------------
 drivers/mfd/pm8921-core.c                         |  9 +++++----
 drivers/mfd/wm5110-tables.c                       |  8 ++++++++
 include/linux/mfd/arizona/registers.h             |  9 +++++++++
 include/linux/mfd/core.h                          |  2 +-
 7 files changed, 72 insertions(+), 29 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
