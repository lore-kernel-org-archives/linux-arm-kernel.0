From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Oct 2012 15:01:09 +0000
Subject: [PATCH v2 1/5] ARM: gic: move register definitions into .c file
In-Reply-To: <1351695517-5636-2-git-send-email-robherring2@gmail.com>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
 <1351695517-5636-2-git-send-email-robherring2@gmail.com>
Message-ID: <20121031150109.GL21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 09:58:33AM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> There's only 1 user of gic registers outside of gic.c, so move the
> register definitions into gic.c. For now, keep GIC_DIST_CNT as Tegra
> uses it.

> -#define GIC_DIST_CTRL			0x000
>  #define GIC_DIST_CTR			0x004

There seems to be a disagreement here.
