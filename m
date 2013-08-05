From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 05 Aug 2013 00:43:39 -0400 (EDT)
Subject: [GIT PULL] MCPM backends update
In-Reply-To: <CAOesGMjB+=auLRTAEfjuW5udJzuj4YS0G4nS7gHmyurZMVdt3Q@mail.gmail.com>
References: <alpine.LFD.2.03.1307221521200.15022@syhkavp.arg>
 <20130804200201.GH10876@quad.lixom.net>
 <alpine.LFD.2.03.1308042058280.14472@syhkavp.arg>
 <CAOesGMjB+=auLRTAEfjuW5udJzuj4YS0G4nS7gHmyurZMVdt3Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1308050032350.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 4 Aug 2013, Olof Johansson wrote:

> On Sun, Aug 4, 2013 at 6:19 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > So could we stop fooling around please?
> >
> > I'd strongly plea for you to just pull this stuff as it is now.  We've
> > wasted way too much time on the issue of a proper location for this code
> > and other drivers are being gated on this. I think that
> > drivers/platform/vexpress is Innocent enough to cause no harm.  So
> > _please_ let's just use that and move it _if_ we find a more optimal
> > location in the future.
> >
> > Please ?
> 
> How about this:
> 
> I'll pick this up in an unstable branch for now with three commits on
> top of, which I will send out in a minute. Those three commits move
> the code back next to tc2_pm, and has two tiny cleanups (quicker to do
> that than go back and loop with code review). If you and Pawel and
> Lorenzo are happy with those commits, I'll move the whole branch over
> into next/soc and we'll lock it in for 3.12.

I have no problem with that. Whatever makes you feel good (or at least 
somewhat better) about this code is fine by me.

I'm supposed to be on vacation right now, but I just cannot imagine 
having _another_ merge window passing by without this functionality 
being merged, which is why I'm replying nevertheless.  So by all means 
please be my guest.


Nicolas
