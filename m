From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Jul 2013 05:05:23 -0700
Subject: [PATCH v2 1/2] ARM: configs: Enable TI_EDMA in omap2plus_defconfig
In-Reply-To: <1372304523-30742-1-git-send-email-joelf@ti.com>
References: <1372304523-30742-1-git-send-email-joelf@ti.com>
Message-ID: <20130704120523.GM5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Joel Fernandes <joelf@ti.com> [130626 20:48]:
> Build EDMA in by default to avoid fewer people stepping on their toes
> with broken DMA on drivers needing EDMA.

Thanks applying this one into omap-for-v3.11/fixes.

Tony
