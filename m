From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 22 Jan 2012 04:02:29 -0700
Subject: [PATCH 0/3] ARM: OMAP: fix compilation problems with v3.3-rc1
Message-ID: <20120122105942.6508.82335.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix several compilation problems detected with a 2420-only kernel
configuration.  This series is intended for the v3.3-rc merge window.

These patches are available via git at git://git.pwsan.com/linux-2.6 in the
branch "omap2420_compilation_fixes_3.3rc"

- Paul

---

Paul Walmsley (3):
      ARM: OMAP: PRM: fix missing plat/irqs.h build breakage
      ARM: OMAP2+: io: fix compilation breakage on 2420-only configs
      ARM: OMAP: I2C: fix compilation when !CONFIG_OF


 arch/arm/mach-omap2/io.c           |    4 +++-
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    1 +
 drivers/i2c/busses/i2c-omap.c      |    4 +++-
 3 files changed, 7 insertions(+), 2 deletions(-)
