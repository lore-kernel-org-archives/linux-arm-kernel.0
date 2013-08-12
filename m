From: liam.r.girdwood@linux.intel.com (Liam Girdwood)
Date: Mon, 12 Aug 2013 08:40:15 +0100
Subject: [alsa-devel] [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between	codec and cpu DAI
In-Reply-To: <20130810211342.GX23006@n2100.arm.linux.org.uk>
References: <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
 <20130805145644.GV23006@n2100.arm.linux.org.uk>
 <20130805203202.GX23006@n2100.arm.linux.org.uk>
 <20130805220639.GB26637@sirena.org.uk>
 <20130805233015.GY23006@n2100.arm.linux.org.uk>
 <20130806133206.GA6427@sirena.org.uk>
 <20130810161123.GW23006@n2100.arm.linux.org.uk>
 <20130810211342.GX23006@n2100.arm.linux.org.uk>
Message-ID: <1376293215.2385.32.camel@loki>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-08-10 at 22:13 +0100, Russell King - ARM Linux wrote:
> On Sat, Aug 10, 2013 at 05:11:23PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Aug 06, 2013 at 02:32:06PM +0100, Mark Brown wrote:
> > > On Tue, Aug 06, 2013 at 12:30:15AM +0100, Russell King - ARM Linux wrote:
> > > 
> > > > I put it to you that DPCM in mainline is incomplete and nonfunctional
> > > > as it currently stands.  Moreover, it requires either those who know
> > > > that code to continue to develop it, or someone else who understands
> > > > the direction that this code is supposed to go picks up to complete it.
> > > 
> > > I'd be most distressed if it were far off working; it's close enough to
> > > the out of tree code I've worked with and I know there were drivers in
> > > progress when it was submitted.  We've certainly had at least one bug
> > > fix from the out of tree users, I'd be surprised if we had anything more
> > > substantial than bitrot in the current code.
> > 
> > Right, so, I've looked at this again today, and I've sort-of got it
> > working.
> 
> I'm not so sure about that:

Russell, I'm just back from holiday now and have done a quick re test on
Haswell. I can see the correct DAPM path and DPCM state as expected for
Haswell, but let me get through my Inbox today and I'll see where we
have some differences tomorrow.

Liam 
