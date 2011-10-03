From: tony@atomide.com (Tony Lindgren)
Date: Mon, 3 Oct 2011 11:27:06 -0700
Subject: [PATCH 27/30] ARM: omap: select L2X0 cache on omap4
In-Reply-To: <4E89481C.4070405@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-28-git-send-email-arnd@arndb.de>
	<4E89481C.4070405@ti.com>
Message-ID: <20111003182705.GD6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111002 21:55]:
> On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> > The cache controller needs to be enabled for the
> > cortex-a9 specific errata that are also selected
> > to work.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	

Acked-by: Tony Lindgren <tony@atomide.com>
