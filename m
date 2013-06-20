From: horms@verge.net.au (Simon Horman)
Date: Thu, 20 Jun 2013 21:08:37 +0900
Subject: [PATCH 1/2] serial: sh-sci: HSCIF support
In-Reply-To: <201306191708.46525.arnd@arndb.de>
References: <1371440327-30512-1-git-send-email-horms+renesas@verge.net.au>
 <CAO3366zWrYFYNaXNWpUvc8KpxjwYVoHz2O5fV33QFSTN2-H7aQ@mail.gmail.com>
 <20130619123324.GG32292@verge.net.au>
 <201306191708.46525.arnd@arndb.de>
Message-ID: <20130620120836.GB27177@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 05:08:46PM +0200, Arnd Bergmann wrote:
> On Wednesday 19 June 2013, Simon Horman wrote:
> > > This is of course trivially fixed, but I have completely lost track of
> > > the transmogrifications this patch has been subjected to. What's the
> > > procedure?
> > 
> > Hi Ulrich,
> > 
> > perhaps the best way forward would be for you to post an incremental patch
> > on top of either the sh-sci branch or renesas-next-20130618 tag of
> > my renesas tree on kernel.org.
> 
> I'm not sure where we stand on this series at the moment. Should
> I pull v3, has Olof already pulled it, or should I wait for an
> update?

Hi Arnd,

my preference is for you to wait for an update.

In order to move things forwards I will post a proposed
fix shortly. I believe that the warnings are for conditions
that can never occur and thus in my patch I will propose initialising the
variables that are flagged as being used uninitialised.
