From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 30 Sep 2014 13:46:06 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <542A9771.2030401@redhat.com>
References: <20140929080637.GB12506@ulmo> <20140929092301.GC4388@lukather>
 <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo> <20140929113436.GA4081@lukather>
 <20140929135358.GC30998@ulmo> <20140929155718.GD4081@lukather>
 <20140930045957.GA29874@ulmo> <542A9771.2030401@redhat.com>
Message-ID: <20140930114605.GA23304@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 01:43:45PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 09/30/2014 06:59 AM, Thierry Reding wrote:
> > On Mon, Sep 29, 2014 at 05:57:18PM +0200, Maxime Ripard wrote:
> 
> <snip>
> 
> >> But sure, you can still try to point new issues, get an obvious and
> >> robust solution, and then discard the issue when the solution doesn't
> >> go your way...
> > 
> > And you've already proven that you're completely unwilling to even
> > consider any other solution than what was originally proposed, so I
> > really don't see how discussing this further with you is going to be
> > productive.
> 
> That is not true, we have seriously considered various other alternatives,
> as you know since you've participated in the discussion about them.
> 
> And we've found them all lacking, mostly because they are 10 times as
> complicated.
> 
> You've made your point that you don't like this solution quite loudly
> already, and we've all heard you. However you seem to be mostly alone in
> this. Even the clk maintainer has said that what we want to do is
> exactly how clocks are supposed to be used in dt.
> 
> If you don't like this no-one is forcing you to use the clocks property
> in your own code. If it is not there, simplefb will behave exactly as
> before.
> 
> Now since you're the only one very vocally against this, and a lot
> of people are in favor of this and have a need for this, can we
> please just get this merged and get this over with ?

Whatever. I no longer care.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/201cf473/attachment-0001.sig>
