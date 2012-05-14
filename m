From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 14 May 2012 15:55:04 -0400 (EDT)
Subject: [PATCH 01/11] OMAP2+: Add SoC specific map_io functions
In-Reply-To: <4FB11F63.2010108@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-2-git-send-email-b-cousson@ti.com>
 <20120504175942.5ceb8e91@skate> <4FB11F63.2010108@ti.com>
Message-ID: <alpine.LFD.2.02.1205141553280.1640@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 May 2012, Cousson, Benoit wrote:

> Salut Thomas,
> 
> Sorry for the delay.
> 
> On 5/4/2012 5:59 PM, Thomas Petazzoni wrote:
> > Hello Benoit,
> > 
> > Le Fri, 23 Sep 2011 22:23:09 +0200,
> > Benoit Cousson<b-cousson@ti.com>  a ?crit :
> > 
> > > Add SoC specific map_io function to be used by the generic DT
> > > board file. This is an intermediate step before having some
> > > generic DT aware map_io function.
> > > 
> > > Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> > > Cc: Tony Lindgren<tony@atomide.com>
> > 
> > Do you know if some progress has been made on having a generic DT aware
> > map_io function, or is the per-SoC ->map_io() function still the
> > recommended way of handling SoC having different requirements of static
> > mappings at boot time?
> 
> Mmm, Maybe I'm wrong, but I'm not sure people are really pushing to store that
> inside DT. But to be honest, I don't really know :-)

In general, static vs dynamic IO mappings are just some Linux 
implementation details.  This distinction does not belong in DT.


Nicolas
