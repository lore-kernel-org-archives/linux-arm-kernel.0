From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Sep 2010 11:46:13 -0700
Subject: [PATCH 0/3] Few omap1 patches for v2.6.37 merge window
Message-ID: <20100930184459.12052.14542.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some omap1 related patches I've picked up for the upcoming
merge window.

Regards,

Tony

---

Janusz Krzysztofik (3):
      OMAP1: Add support for SoC camera interface
      OMAP1: Amstrad Delta: add support for camera
      OMAP1: Amstrad Delta: add camera controlled LEDS trigger


 arch/arm/mach-omap1/board-ams-delta.c     |   69 +++++++++++++++++++++++++++++
 arch/arm/mach-omap1/devices.c             |   43 ++++++++++++++++++
 arch/arm/mach-omap1/include/mach/camera.h |   11 +++++
 3 files changed, 123 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/camera.h

-- 
Signature
