From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Sep 2016 16:47:30 +0100
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <57D8137F.8040508@laposte.net>
References: <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net> <20160912135549.GA14165@leverpostej>
 <57D6D2A9.3010006@laposte.net> <20160912165637.GF14165@leverpostej>
 <57D7CF17.2050905@laposte.net> <20160913131208.GA23336@leverpostej>
 <57D8137F.8040508@laposte.net>
Message-ID: <20160913154722.GD23336@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 04:55:59PM +0200, Sebastian Frias wrote:
> On 09/13/2016 03:12 PM, Mark Rutland wrote:
> >> Exactly, that is why I was thinking it would take less "review" time.
> >> Indeed, if there is no driver, why would it matter what those bindings
> >> are?
> > 
> > If you believe that the bindings don't matter, then there is absolutely
> > no reason for them to exist in the first place.
> > 
> > If those binding matter to *anyone*, then those collating the bindings
> > have some responsibility of stewardship, and that includes
> > review/maintenance/etc.
> 
> The thing is that right now it seems the "responsibility of stewardship"
> lies only within "Linux", whereas DT is proposed as open for everybody,
> Bootloaders, FreeBSD, etc.
> 
> In that case, shouldn't the "responsibility" be shared?

Ideally, yes.

Which is one of the reasons devicetree.org was set up as a common forum
for projects to collaborate on devicetree.

Thanks,
Mark.
