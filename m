From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 25 Jun 2012 12:45:51 +0200
Subject: [PATCH 3/3] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <20120625084656.GA4037@opensource.wolfsonmicro.com>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <27366523.LjLfRK1TqH@ax5200p>
 <20120625084656.GA4037@opensource.wolfsonmicro.com>
Message-ID: <5989569.YVq7UL4sPq@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 25. Juni 2012, 09:46:56 schrieb Mark Brown:
> On Sun, Jun 24, 2012 at 03:27:42PM +0200, Marc Dietrich wrote:
> > On Sunday 24 June 2012 13:31:51 Mark Brown wrote:
> > > > there should be some initial value, e.g. regulator-default-microvolt,
> > > > as
> > > > the original driver (from 2.6.32 ages) did. This way the maximum value
> > > > can be set
> > > 
> > > That's *never* been in mainline, and nobody even bothered trying to
> > > submit it.
> > 
> > which was the best thing to do ;-)
> 
> Well, no - had there been some attempt to submit it it might've helped
> stop people writing constaints like this.

by saying "best thing to do" I meant that the driver isn't mainline compatible 
as it is based on some cross OS HAL. On the other hand, I think the current
tps6586x could be enhanced to include such a field. I don't know if the 
regulator api supports this, though.

Marc
