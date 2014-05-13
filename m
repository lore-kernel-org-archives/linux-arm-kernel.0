From: horms@verge.net.au (Simon Horman)
Date: Wed, 14 May 2014 08:53:35 +0900
Subject: [PATCH v5 01/11] ARM: shmobile: r7s72100: document MSTP clock
 support
In-Reply-To: <20140513215929.GA3967@katana>
References: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
 <1398765822-2314-2-git-send-email-wsa@the-dreams.de>
 <20140513000513.5943.68810@quantum>
 <20140513015708.GA29336@verge.net.au>
 <20140513215929.GA3967@katana>
Message-ID: <20140513235335.GF6784@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 11:59:29PM +0200, Wolfram Sang wrote:
> Simon,
> 
> > Its a getting a little to close to rc6 for me to take this series for v3.16,
> > especially considering some bits seem to need tweaking (I am thinking of sci).
> > 
> > Could you either:
> > 
> > * Re-post it without the sci changes and
> >   I'll look at queuing it up for v3.17 or;
> 
> If it is possible and does not cause too much burden for you, I'd prefer
> to include it soonish and handle the fixups incrementally. Since it
> touches a few files which change a lot, rebasing and retesting is extra
> work (done twice for this series IIRC) and thus I'd prefer to do the
> clenaups as seperate patches.
> 
> So, if no one objects, I'll resend tomorrow with Geerts fixup folded
> into my series and retested against latest renesas/devel.

I will do my best. But I need to have pull-requests sent off
to the arm-soc maintainers before rc6 appears. And ideally patches
should have been present in next for a day before I send such a request.
So by my calculations I need to push things to my next tree very
soon (i.e. today) in order to reach the above mentioned criteria.
