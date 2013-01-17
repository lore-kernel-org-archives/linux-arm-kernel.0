From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 17 Jan 2013 19:00:00 +0000 (UTC)
Subject: [PATCH v7 19/22] ARM: OMAP3: clock data: get rid of unused USB
 host clock aliases and dummies
In-Reply-To: <20130117170321.GJ14149@atomide.com>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-20-git-send-email-rogerq@ti.com>
 <20130117170321.GJ14149@atomide.com>
Message-ID: <alpine.DEB.2.00.1301171854280.14118@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On Thu, 17 Jan 2013, Tony Lindgren wrote:

> * Roger Quadros <rogerq@ti.com> [130117 03:34]:
> > We don't need multiple aliases for the OMAP USB host clocks and neither
> > the dummy clocks so remove them.
> 
> It's best that Paul queues this and the next patch as these clock alias
> clean-up patches can be done separately. That way the dependency between
> arch/arm/*omap* code is cut away as these files should be moved to live
> under drivers/clk/omap.

Per Tony's request, I'll queue these two cleanup patches for 3.10 -- or 
whatever Linus will call it.


- Paul
