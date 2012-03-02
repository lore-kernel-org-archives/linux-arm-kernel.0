From: alan@signal11.us (Alan Ott)
Date: Fri,  2 Mar 2012 17:24:35 -0500
Subject: [PATCH v3 0/5] ARM: Tegra: cleanup patches from Arnd Bergmann
In-Reply-To: <1330721884-8495-1-git-send-email-alan@signal11.us>
References: <1330721884-8495-1-git-send-email-alan@signal11.us>
Message-ID: <1330727075-10974-1-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 3 of the patch set.

Changes:
	* change of logic (and commit message change) for
	  "select USB_ULPI if USB is selected"
	* dropped THUMB2 patch

Arnd Bergmann (5):
  ARM: tegra: do not hide dma declarations
  ARM: tegra: select CPU_FREQ_TABLE
  ARM: tegra: build localtimer support only when needed
  ARM: tegra: select USB_ULPI if USB is selected
  ARM: tegra: export usb phy symbols

 arch/arm/mach-tegra/Kconfig            |    6 ++++--
 arch/arm/mach-tegra/Makefile           |    3 ++-
 arch/arm/mach-tegra/include/mach/dma.h |    4 ----
 arch/arm/mach-tegra/usb_phy.c          |   11 +++++++++++
 4 files changed, 17 insertions(+), 7 deletions(-)
