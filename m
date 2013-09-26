From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 25 Sep 2013 23:10:10 -0700 (PDT)
Subject: [PATCH] ARM: shmobile: Add r8a7790 thermal sensor DT device
In-Reply-To: <20130926002919.GB13464@verge.net.au>
References: <20130925231119.16473.31647.sendpatchset@w520>
 <20130925233552.GA20882@verge.net.au>
 <CANqRtoRPAMDDgPo5kBTxnEoVG7N1UwxWGBuz+ORzTPqP=+7r_A@mail.gmail.com>
 <20130926002919.GB13464@verge.net.au>
Message-ID: <87y56km7up.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon, Magnus

> > >> Hook up the single channel thermal sensor via DT
> > >> on r8a7790. The information used by the platform
> > >> device has been verified against the data sheet.
> > >>
> > >> Signed-off-by: Magnus Damm <damm@opensource.se>
> > >
> > > Hi Magnus,
> > >
> > > I would prefer if this was split into two patches.
> > > An SoC patch that updates clock-r8a7790.c.
> > > And a DT patch which updates r8a7790.dtsi.
> > 
> > Sure, that's fine with me. I will do that from now on.
> 
> Thanks. I'm trying to reduce dependencies/conflicts between
> branches. I'm not sure how well it will pan out. But that is my aim
> at the moment.
> 
> > I believe that common clock framework will allow us to handle all
> > within a single dtsi patch.

About thermal on H2/M2 (= Gen2),
I am concerned about whether Gen1/Gen2 thermal chip have a compatible,
since H2 datasheet v0.05 <-> v0.6 seems have different register mapping,
and M2 is very different from Gen1.
Now, I'm confirming about it

Best regards
---
Kuninori Morimoto
