From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 25 Oct 2011 23:43:06 -0700
Subject: [PATCH 3/3] arm/dt: tegra: add dts file for paz00
In-Reply-To: <2821699.TeokzqUUds@ax5200p>
References: <cover.1319313019.git.marvin24@gmx.de>
	<90ee88bcde84141e0280ffa4ccbd288462489eba.1319313020.git.marvin24@gmx.de>
	<74CDBE0F657A3D45AFBB94109FB122FF173E1B4189@HQMAIL01.nvidia.com>
	<2821699.TeokzqUUds@ax5200p>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173E1B4536@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietrich wrote at Tuesday, October 25, 2011 1:05 PM:
> On Monday 24 October 2011 22:16:15 Stephen Warren wrote:
> > Marc Dietrich wrote at Saturday, October 22, 2011 2:17 PM:
> > > * NOT FOR COMMIT *
> > >
> > > This just adds the dts for paz00. I like to add it to board-dt as
> > > well as soon as I find out which tree to base it on.
> >
> > ...
> >
> > > +++ b/arch/arm/boot/dts/tegra-paz00.dts
> >
> > One thing that cross my mind when writing the TrimSlice support and I
> > forgot to mention: Should these files be named ${soc}-${board}.dts or
> > ${vendor}-${board}.dts (tegra-paz00.dts or toshiba-paz00.dts or
> > compal-paz00.dts). I'm OK either way; just want to follow any outside
> > expectations.
> 
> I also don't know. I prefer compal for paz00 because Toshiba's code name was
> procyon (I think) and I don't want to change all the naming. Also Toshiba
> showed no interest in helping us, so I don't see why they should get the fame.

Well, it's more about correctly defining what the HW is than advertising,
fame, or support!
 
-- 
nvpublic
