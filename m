From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Jan 2011 17:25:46 -0800
Subject: [PATCH 0/7] OMAP compile warning fix
In-Reply-To: <1295238680-26738-1-git-send-email-balbi@ti.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
Message-ID: <20110120012545.GQ4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [110116 20:30]:
> Hi Tony,
> 
> I gave it a shot at dropping a few compile warnings
> from omap1-only and omap2-only builds.
> 
> Following are 7 patches which I came up with. All
> compile tested with omap1_defconfig and omap2_defconfig
> (the latter being a result of omap2plus_defconfig -
> omap3 and omap4 support and adding any other config option
> which was disabled)
> 
> There are a few more warnings to clean up, though. I didn't
> tackle all of them.

Thanks, adding all but the last one into devel-cleanup
for the next merge window. Let's see what Paul says about
the last one.

Tony
