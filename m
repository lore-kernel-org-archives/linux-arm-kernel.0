From: peda@axentia.se (Peter Rosin)
Date: Thu, 18 Jan 2018 12:46:13 +0100
Subject: [PATCH v2 0/3] Device tree fixes for Axentia TSE-850 and Nattis
Message-ID: <20180118114616.6639-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Here's a series that is of the "documentation" kind. It fixes things
that don't really need fixing, but the fixes are correct none-the-less
and should prevent possible confusion.

Changes since v1:

- One more fix added to patch 1/3. The size of the rootfs partition
  should be 504MB, as the flash is 512MB total.

Sorry for the noise.

Cheers,
Peter

Peter Rosin (3):
  ARM: dts: at91: nattis: use up-to-date mtd partitions
  ARM: dts: at91: nattis: add lvds-encoder
  ARM: dts: at91: tse850: make the sound dai cell count explicit

 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 58 ++++++++++++++++++++++-------
 arch/arm/boot/dts/at91-tse850-3.dts         |  1 +
 2 files changed, 45 insertions(+), 14 deletions(-)

-- 
2.11.0
