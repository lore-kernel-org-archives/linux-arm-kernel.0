From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Feb 2011 13:09:18 -0800
Subject: [PATCH 4/5] omap2plus: omap4: Set NR_CPU to 2 instead of default 4
In-Reply-To: <1297510187-31547-5-git-send-email-santosh.shilimkar@ti.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-5-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110214210918.GJ20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110212 03:28]:
> The omap2plus_defconfig picks default NR_CPU value as 4 which isn't
> correct for OMAP4430. Available CPUs are ony 2, so fix the same.

I'll queue this for the upcoming merge window.

Tony
