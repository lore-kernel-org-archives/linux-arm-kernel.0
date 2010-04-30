From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Apr 2010 13:50:03 -0700
Subject: [PATCH 11/11] omap2/3/4: Disable CONFIG_FB_OMAP in omap3_defconfig
In-Reply-To: <20100430203411.25812.30019.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
	<20100430203411.25812.30019.stgit@baageli.muru.com>
Message-ID: <20100430205003.GG29604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100430 13:32]:
> Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
> at least on zoom3 for multi-omap. Disable CONFIG_FB until the
> omap FB code is fixed.

This one I'll drop as soon as the problem is sorted out with
CONFIG_FB_OMAP.

Tony
