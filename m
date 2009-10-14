From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Oct 2009 14:49:36 -0700
Subject: [PATCH 4/6] omap: headers: Move mtd-xip.h to be mach-omap1 specific
In-Reply-To: <20091014213748.30227.71513.stgit@kaulin.muru.com>
References: <20091014213748.30227.71513.stgit@kaulin.muru.com>
Message-ID: <20091014214936.30227.98582.stgit@kaulin.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These registers are omap1 specific.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

 arch/arm/mach-omap1/include/mach/mtd-xip.h |   61 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/mtd-xip.h  |   61 ----------------------------
 2 files changed, 61 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/mtd-xip.h
 delete mode 100644 arch/arm/plat-omap/include/mach/mtd-xip.h

diff --git a/arch/arm/plat-omap/include/mach/mtd-xip.h b/arch/arm/mach-omap1/include/mach/mtd-xip.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/mtd-xip.h
rename to arch/arm/mach-omap1/include/mach/mtd-xip.h
