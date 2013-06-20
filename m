From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 12:19:25 +0200
Subject: [PATCH] gpio: rcar: fix gpio_rcar_of_table
In-Reply-To: <20130620005017.GA20643@verge.net.au>
References: <201306191750.43755.arnd@arndb.de>
 <20130620005017.GA20643@verge.net.au>
Message-ID: <201306201219.25744.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Simon Horman wrote:
> 
> On Wed, Jun 19, 2013 at 05:50:43PM +0200, Arnd Bergmann wrote:
> > The device table needs to be terminated with an empty element.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > I've just added this patch on top of the arm-soc next/drivers branch
> > that introduced the build warning.
> 
> Thanks, have you pushed it there or do I need to add it and
> send a pull-request?

I've applied this directly.

	Arnd
