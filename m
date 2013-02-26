From: horms@verge.net.au (Simon Horman)
Date: Tue, 26 Feb 2013 21:15:27 +0900
Subject: [PATCH 1/4] ARM: shmobile: sh73a0: fix Z and ZG clock hierarchy
In-Reply-To: <Pine.LNX.4.64.1302260707480.15531@axis700.grange>
References: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
 <1361553474-27022-2-git-send-email-g.liakhovetski@gmx.de>
 <20130226042946.GB26820@verge.net.au>
 <CANqRtoRjs=OxsoUQrcL6nJG-o1RpxefO3BrjBj_A2GV8HNW=qQ@mail.gmail.com>
 <20130226054319.GA25356@verge.net.au>
 <Pine.LNX.4.64.1302260707480.15531@axis700.grange>
Message-ID: <20130226121527.GC17704@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 07:09:00AM +0100, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Tue, 26 Feb 2013, Simon Horman wrote:
> 
> > On Tue, Feb 26, 2013 at 02:36:24PM +0900, Magnus Damm wrote:
> > > On Tue, Feb 26, 2013 at 1:29 PM, Simon Horman <horms@verge.net.au> wrote:
> > > > On Fri, Feb 22, 2013 at 06:17:51PM +0100, Guennadi Liakhovetski wrote:
> > > >> Z and ZG clocks on sh73a0 have pll0 as their parent, not pll1.
> > > >
> > > > Thanks I have applied this to the soc5 branch and thus queued it up for v3.10.
> > > > Please let me know if you would prefer me to push it as a fix for v3.9.
> > > > And in that vein, if you regard it as -stable material.
> > > 
> > > Thanks.
> > > 
> > > Perhaps other people disagree, but I recommend not being so trigger
> > > happy with -stable unless it will potentially give us some upside.
> > > AFAIK there is no in-tree consumer of this clock anyway, so involving
> > > -stable without further testing seems like a lot of hassle with no
> > > real benefit.
> > 
> > If there is no in-tree consumer then it is not v3.9 or -stable material.
> 
> Just to confirm, that I'm not aware of any current consumers of these 
> clocks, so, no rush with stable.

Thanks. I'll leave it queued up for 3.10.
