From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 14 Nov 2014 22:13:05 -0500
Subject: [GIT PULL] ARM: mvebu: Fixes for v3.18
In-Reply-To: <20141109225155.GC3698@titan.lakedaemon.net>
References: <20141101222033.GA3698@titan.lakedaemon.net>
 <20141109034131.GQ3698@titan.lakedaemon.net>
 <CAOesGMiq_1vOOqMaV6Fma__d9vkTbLeEYeNuyF2jt7YNXM9ECA@mail.gmail.com>
 <20141109225155.GC3698@titan.lakedaemon.net>
Message-ID: <20141115031305.GN3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 09, 2014 at 05:51:55PM -0500, Jason Cooper wrote:
> On Sun, Nov 09, 2014 at 11:29:55AM -0800, Olof Johansson wrote:
> > Hi Jason,
> > 
> > On Sat, Nov 8, 2014 at 7:41 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > > On Sat, Nov 01, 2014 at 06:20:33PM -0400, Jason Cooper wrote:
> > >> Guys,
> > >>
> > >> Here's a couple of fixes I've gathered so far for mvebu, nothing
> > >> exciting as these are quite old and were in -next for several weeks.
> > >>
> > >> Please pull.
> > >
> > > Gentle ping?
> > 
> > Whoops, I've missed this one. Partially becaose you've forgotten to cc
> > arm at kernel.org, which is how I usually keep track of pull requests.
> 
> Yep, my mistake.  Bit scattered atm.
> 
> > I sent the pull request to Linus last night, I'll include this for -rc5.
> 
> No problem.

Well, looks like it's a good thing this hasn't been pulled yet.  Please
hold off for a v2.  Arnd pointed me to the fact that the top of this
branch clashed with genirq changes in irqchip/core.  I'll squash in a
fix shortly and resend.

Yes, I'm aware of the irony :-P

thx,

Jason.
