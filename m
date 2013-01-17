From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jan 2013 23:00:34 +0200
Subject: [PATCH v7 19/22] ARM: OMAP3: clock data: get rid of unused USB
 host clock aliases and dummies
In-Reply-To: <alpine.DEB.2.00.1301171854280.14118@utopia.booyaka.com>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-20-git-send-email-rogerq@ti.com>
 <20130117170321.GJ14149@atomide.com>
 <alpine.DEB.2.00.1301171854280.14118@utopia.booyaka.com>
Message-ID: <20130117210034.GA27671@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 17, 2013 at 07:00:00PM +0000, Paul Walmsley wrote:
> Hi Roger,
> 
> On Thu, 17 Jan 2013, Tony Lindgren wrote:
> 
> > * Roger Quadros <rogerq@ti.com> [130117 03:34]:
> > > We don't need multiple aliases for the OMAP USB host clocks and neither
> > > the dummy clocks so remove them.
> > 
> > It's best that Paul queues this and the next patch as these clock alias
> > clean-up patches can be done separately. That way the dependency between
> > arch/arm/*omap* code is cut away as these files should be moved to live
> > under drivers/clk/omap.
> 
> Per Tony's request, I'll queue these two cleanup patches for 3.10 -- or 
> whatever Linus will call it.

do you mean v3.9 ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/6f1fd568/attachment.sig>
