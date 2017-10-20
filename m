From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Oct 2017 17:54:33 +0100
Subject: [PATCH] ARM: compressed: discard ksym/kcrctab input section
In-Reply-To: <CAKv+Gu_FqQjXLH6C8+pVyvfWqgL+e2g8geRG+t0kBxt49ObY-Q@mail.gmail.com>
References: <CAKv+Gu_t+oLJKGzy3LxgLZqqYsd9eQiwZRr6dgPbqpsHnQUUxw@mail.gmail.com>
 <874lr4d8gm.fsf@free-electrons.com>
 <20171012094517.GB20805@n2100.armlinux.org.uk>
 <CAKv+Gu_+D+d+5Zi8LRmi3_sHEVx-FLLKHsi9aUUmNB8VvcHANQ@mail.gmail.com>
 <878tg56dtn.fsf@free-electrons.com>
 <CAKv+Gu_q0A+42ht1f4o_SToWSV4OBThV=gtyfBoGYFZyKWNW5Q@mail.gmail.com>
 <20171020161133.GG20805@n2100.armlinux.org.uk>
 <CAKv+Gu9Ygu4UELUbWD8sTzdL8ZQRWPAtQWaM6qTd2GyzuEDN5g@mail.gmail.com>
 <20171020163207.GH20805@n2100.armlinux.org.uk>
 <CAKv+Gu_FqQjXLH6C8+pVyvfWqgL+e2g8geRG+t0kBxt49ObY-Q@mail.gmail.com>
Message-ID: <20171020165433.GI20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 05:36:08PM +0100, Ard Biesheuvel wrote:
> Why would you have to choose between these patches? You can simply
> apply mine as a bug fix, and postpone the le_struct.h discussion for
> the next cycle.

It's not a choice between these two patches.  I think we need Arnd's
patch, because we know that fixes Romain Izard's problem.  If I apply
just your patch, then Gregory stops complaining, and there'll be
nothing to remind us of this issue - Romain isn't shouting about it.
That's a problem, because it's a real bug that then gets forgotten
about.

Or do we have evidence that your patch fixes Romain Izard's problem
as well?  I don't see any such suggestion.

So, let me go back to the dart board... I just don't have the
information to be able to make any decision on this, so stop asking
me for a decision on something I know nothing about.  Either provide
me with some information I can base a decision on, or stop asking
for a decision.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
