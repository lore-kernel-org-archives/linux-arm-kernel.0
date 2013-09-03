From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 3 Sep 2013 13:35:46 -0400
Subject: [GIT PULL V2 2/2] ARM: mvebu: MSI mvebu changes for v3.12
In-Reply-To: <CAOesGMiLURZGhHTh15QsLRFoY8iJU4QC36FrGUsd5jUu9JMm7Q@mail.gmail.com>
References: <20130814191011.GD13964@titan.lakedaemon.net>
 <20130814192317.GE13964@titan.lakedaemon.net>
 <20130830202526.GW19598@titan.lakedaemon.net>
 <CAOesGMhRJjB9veSVMYHMFPqWYeMd8n9YcnKVtZxav1vyfKnbhw@mail.gmail.com>
 <20130903154708.GJ19598@titan.lakedaemon.net>
 <CAOesGMiLURZGhHTh15QsLRFoY8iJU4QC36FrGUsd5jUu9JMm7Q@mail.gmail.com>
Message-ID: <20130903173546.GK19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Tue, Sep 03, 2013 at 09:21:51AM -0700, Olof Johansson wrote:
> Jason,
> 
> No code is lost, no code is rejected, it's just going to wait for 3.13.

Ack.  Bummed, but Ack.

> Stirring up drama over this is just going to be counterproductive for
> all parties.

I'm pissed, but I'm not a school girl.  I can't read your mind (or
Arnd's for that matter).  So if I don't hear anything from you guys, I
have to assume that my pulls are ok.

Usually one of you pokes me within a few days if something is wrong.
Had that happened, we wouldn't be here right now.

So, my more rational response to this is: How do we prevent this in the
future?  If I don't hear anything from you in a few days, should I poke
Arnd/Kevin to take a look at it?  I'm not really keen on making noise
like that by default.  Any other ideas?

thx,

Jason.



> On Tue, Sep 3, 2013 at 8:47 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Tue, Sep 03, 2013 at 08:04:51AM -0700, Olof Johansson wrote:
> >> On Fri, Aug 30, 2013 at 1:25 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> >> > Arnd, Olof,
> >> >
> >> > As requested, rebased on top of mvebu/drivers to resolve conflicts
> >> > internally.
> >>
> >> Sorry, I didn't have a chance to pull this in before the last -next
> >> before the merge window (which was already very late), so it'll have
> >> to wait for 3.13. Please send a fresh pull request of this branch once
> >> -rc1 is out.
> >
> > I'm sorry Olof, but I have to call bullshit.  I originally sent this
> > pull-request on August 14th (3 _weeks_ ago):
> >
> > http://www.spinics.net/lists/arm-kernel/msg267243.html
> >
> > I heard crickets until your reply on August 29th (2 _weeks_ later):
> >
> > http://www.spinics.net/lists/arm-kernel/msg270826.html
> >
> > Which I respun and resent within a day on August 30th:
> >
> > http://www.spinics.net/lists/arm-kernel/msg271170.html
> >
> >
> > Also, these patches were in -next for at least a week _before_ I sent my
> > first pull request on August 14th.  So they've been tested for
> > _four_weeks_ ...
> >
> > I understand you're busy with other work, like all of us, but it would
> > seem that the baton passing between you, Arnd, and Kevin could use some
> > tweaking.
> >
> > The situation is the exact same for the dove branch.
> >
> >
> > :(
> >
> > Jason.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
