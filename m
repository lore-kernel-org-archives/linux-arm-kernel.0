From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 9 Apr 2013 01:20:11 -0400 (EDT)
Subject: [GIT PULL] Multi Cluster Power Management infrastructure
In-Reply-To: <20130407000237.GI17995@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.03.1303251219530.1372@syhkavp.arg>
 <alpine.LFD.2.03.1304042138160.1171@syhkavp.arg>
 <20130405094159.GH17995@n2100.arm.linux.org.uk>
 <201304052233.25630.arnd@arndb.de>
 <20130407000237.GI17995@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1304090006140.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 7 Apr 2013, Russell King - ARM Linux wrote:

> On Fri, Apr 05, 2013 at 10:33:25PM +0200, Arnd Bergmann wrote:
> > On Friday 05 April 2013, Russell King - ARM Linux wrote:
> > > 
> > > Now, I'm currently on holiday.  I'm going to be on holday until after
> > > mid-April.  I'm not pulling anything until then.  I'm not applying anything
> > > until then.  I'm not even reading this mailbox - and given current mail
> > > rates at 300-400 messages per day, I will *not* be reading back over a
> > > fortnights worth of email.
> > 
> > I haven't reviewed the patches before, and only heard of the controversy
> > from Nico's email yesterday. Independent of your personal situation and
> > who implemented the code, I think it's clear that a lot of people (not
> > just Linaro) want to see it get merged and not having it upstream is
> > blocking platform specific code from getting put into arm-soc.
> 
> Nicolas is doing what he always does when he doesn't get his own way - he
> tries to force his way.  This is exactly what's going on here...

Since you're willfully blocking my way, I have no choice but to force 
it.  Are you expecting me to stand still?

> > Since you are currently on holiday, I think it's best if we at least put
> > it into asm-soc as a for-rmk/mcpm branch in order to give it coverage
> > in linux-next and let us merge the dependent platform code into "late"
> > branches for 3.10. I still hope the nontechnical issues can be resolved
> > in time to let you pull it into your tree before the merge window.
> 
> I doubt it will.  The way I now feel, I feel betrayed by Linaro, and
> I feel that they have done me a great disservice.  I don't see that
> there's anything Linaro has to offer me in way of work (if they could,
> then they would be able to tell me what areas they have available -
> but they can't even do that.)

Oh come on, please cut that crap.  We gave you complete freedom to 
suggest what _you_ want to work on.  But apparently you can't even do 
that either.

> How can this be resolved?  I've no idea, that's entirely up to Linaro
> and its management to work out whether they actually have any work
> available.

What does it have to do with the pull request I sent to you, given that 
it has been made clear now that Linaro won't pay you for this?  Are you 
expecting money from Linaro before sending those patches upstream?

> So no, _I_ can't resolve it until Linaro gets a handle on what the hell
> that organization wants to do.

That organization wants you, the prime ARM Linux kernel expert above 
all, to determine by yourself a list of things where your work could 
benefit ARM Linux the most.  Then we'll select in your list some items 
we want you to work on our behalf in exchange for money.  How can I make 
it more clear?

If patch review is part of the deal, that would be for work in progress, 
and _not_ for completed patches.  The patches presented here used to be 
work in progress during Q4 of last year but they are _not_ work in 
progress anymore.  So please get a grip and look towards the future not 
in the past.

> But the whole message here is: if you fuck me around commercially, you
> can't *not* expect it to have an impact on what I volunteer to do, and
> you'd better *not* put work-items on the table and then take them away
> again, and then end up demanding that they be done for gratis just
> because of my position.  *That* is grossly unfair.

Well, as a community maintainer, you have to follow the established 
community process.  As a community contributor, I have to follow the 
process too.  And the community doesn't give a damn about the success of 
your commercial arrangements nor Linaro's.  As far as the community is 
concerned, I did my part, so I'm politely asking you that you do yours.

Of course, your community maintainer work is done on a volunteer basis 
and I fully appreciate that.  That means I cannot impose on you to merge 
my patches.

However, this patch set has gone through all the normal community review 
process.  No one objects to its merge into mainline.  No one but you, 
and your arguments at this point are completely non technical.

In that case you have to accept that I might seek another maintainer to 
judge the technical merit of those patches and merge them upstream.  
Linus has made it clear many times that maintainers can be bypassed if 
need be.

Any commercial arrangement between you and Linaro remains an orthogonal 
issue, and the discussion about that may continue separately and in 
private if you are still interested.


Nicolas
