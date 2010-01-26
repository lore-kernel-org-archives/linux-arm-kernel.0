From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Tue, 26 Jan 2010 16:10:49 +0000
Subject: [PATCH 01/01] regulator: support max8649
In-Reply-To: <771cded01001260414q4c8df1e0k303772b87bc725eb@mail.gmail.com>
References: <771cded01001120041ue24edabk8e4638ef7151c947@mail.gmail.com>
	<771cded01001120051l44fd76bx80d2fd4b6f60bd0b@mail.gmail.com>
	<20100112115156.GA546@rakim.wolfsonmicro.main>
	<771cded01001250301q465a9f8ma484f597ae9a292f@mail.gmail.com>
	<20100125135628.GB26613@rakim.wolfsonmicro.main>
	<771cded01001252226k342723b3p3ea235fe79c46843@mail.gmail.com>
	<20100126110420.GI15759@rakim.wolfsonmicro.main>
	<771cded01001260354y7c7db25bqa8bbfe000e0c0380@mail.gmail.com>
	<20100126120058.GN15759@rakim.wolfsonmicro.main>
	<771cded01001260414q4c8df1e0k303772b87bc725eb@mail.gmail.com>
Message-ID: <1264522249.3067.79.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-26 at 07:14 -0500, Haojian Zhuang wrote:
> On Tue, Jan 26, 2010 at 7:00 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Tue, Jan 26, 2010 at 06:54:48AM -0500, Haojian Zhuang wrote:
> >> On Tue, Jan 26, 2010 at 6:04 AM, Mark Brown
> >
> >> > I'd expect the time taken to enable to be the voltage multipled by the
> >> > step size rather than divided by the step size?
> >
> >> I don't agree at this point. The unit of step is uV/uSec. The function
> >> should return uSec. So voltage divided by the step is more reasonable.
> >
> > Ah, then the variable step is confusingly named since it's actually a
> > rate of change rather than a step size - I'd suggest rate or something
> > like that instead.
> >
> 
> update this patch.
> 

Applied.

Thanks

Liam
