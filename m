From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 10 Sep 2012 13:29:21 -0400 (EDT)
Subject: [PATCH v3 09/31] arm64: Cache maintenance routines
In-Reply-To: <20120910164815.GB8238@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-10-git-send-email-catalin.marinas@arm.com>
 <201209071928.09999.arnd@arndb.de> <20120910164815.GB8238@arm.com>
Message-ID: <alpine.LFD.2.02.1209101322140.28681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Sep 2012, Catalin Marinas wrote:

> On Fri, Sep 07, 2012 at 08:28:09PM +0100, Arnd Bergmann wrote:
> > On Friday 07 September 2012, Catalin Marinas wrote:
> > > +
> > > +/*
> > > + *	dmac_inv_range(start,end)
> > 
> > all of these appear to be unused now. Can you remove them?
> 
> They aren't currently used but I expect some partners to make use of
> them on their private development. I could drop them from the upstream
> branch temporarily.

Depends.  If your expectation from those partners is a real probability 
then it is best to keep a skeleton in place for them to use, otherwise 
they might get ... creative.  If this is just wild speculation then you 
should drop it.


Nicolas
