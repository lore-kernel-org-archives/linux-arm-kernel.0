From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 17 Oct 2012 10:56:27 +0100
Subject: [GIT PULL] Versatile Express updates for v3.8
In-Reply-To: <20121016183451.GA2799@quad.lixom.net>
References: <1350404650.1242.20.camel@hornet>
 <20121016183451.GA2799@quad.lixom.net>
Message-ID: <1350467787.1242.49.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-10-16 at 19:34 +0100, Olof Johansson wrote:
> Hi Pawel,

> The branch contents looks good, but I wonder if you would mind splitting it up
> across the same kind of topics that we tend to organize arm-soc in?

Sure, no problem.

> Suggestions below.

I can make those two a "drivers" branch indeed:

> > Pawel Moll (8):
> >       hwmon: Versatile Express hwmon driver
> >       ARM: vexpress: Reset driver

I can also split this one into "fixes":

>       ARM: vexpress: Make the debug UART detection more specific

But this series constitutes one logical change and must be applied in
order (the sysreg driver is an essential part), so I'll keep them
together on a "soc" branch:

> >       mfd: Versatile Express config infrastructure
> >       mfd: Versatile Express system registers driver
> >       ARM: vexpress: Add config bus components and clocks to DTs
> >       ARM: vexpress: Start using new Versatile Express infrastructure
> >       ARM: vexpress: Remove motherboard dependencies in the DTS files

If this makes sense, I'll send three pull requests soon.

Cheers!

Pawe?
