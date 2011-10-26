From: marvin24@gmx.de (Marc Dietrich)
Date: Wed, 26 Oct 2011 22:18:55 +0200
Subject: [PATCH 3/3] arm/dt: tegra: add dts file for paz00
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173E1B4536@HQMAIL01.nvidia.com>
References: <cover.1319313019.git.marvin24@gmx.de> <2821699.TeokzqUUds@ax5200p>
	<74CDBE0F657A3D45AFBB94109FB122FF173E1B4536@HQMAIL01.nvidia.com>
Message-ID: <24453918.Ulhj1xIogt@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 October 2011 23:43:06 Stephen Warren wrote:
> Marc Dietrich wrote at Tuesday, October 25, 2011 1:05 PM:
> > On Monday 24 October 2011 22:16:15 Stephen Warren wrote:
> > > Marc Dietrich wrote at Saturday, October 22, 2011 2:17 PM:
> > > > * NOT FOR COMMIT *
> > > > 
> > > > This just adds the dts for paz00. I like to add it to board-dt
> > > > as
> > > > well as soon as I find out which tree to base it on.
> > > 
> > > ...
> > > 
> > > > +++ b/arch/arm/boot/dts/tegra-paz00.dts
> > > 
> > > One thing that cross my mind when writing the TrimSlice support and
> > > I
> > > forgot to mention: Should these files be named ${soc}-${board}.dts
> > > or
> > > ${vendor}-${board}.dts (tegra-paz00.dts or toshiba-paz00.dts or
> > > compal-paz00.dts). I'm OK either way; just want to follow any
> > > outside
> > > expectations.
> > 
> > I also don't know. I prefer compal for paz00 because Toshiba's code name
> > was procyon (I think) and I don't want to change all the naming. Also
> > Toshiba showed no interest in helping us, so I don't see why they
> > should get the fame.
> Well, it's more about correctly defining what the HW is than advertising,
> fame, or support!

define "what the HW is". Warning: the following list is purely fictitious. Any 
similarities between the companies or products mentiond, real or imaginary, 
are coincidental.

	- company A creates a cpu (only the IP) and license it to company N.
	- company N adds some more stuff around it (interfaces, gpu, ...) and 
creates real cpu hw.
	- company T likes the cpu and asks company C to build a computer around it
	- company C takes the evaluation board from company N, modifies it a bit, 
and builds a whole netbook around it
	- company T gets the netbook from company C and adds a operating system 
which will displeased their customers

So how would you define that hw? Or the real question, who made it? And please 
don't take my second argument too serious. I just expressed my anger in an 
improper way at an improper place. Sorry for that.

Marc
