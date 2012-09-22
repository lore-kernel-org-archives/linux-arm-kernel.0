From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Sep 2012 17:21:11 -0700
Subject: [GIT PULL] ARM: OMAP: hwmod/PMU/PRCM patches for 3.7
In-Reply-To: <alpine.DEB.2.00.1209220002290.6510@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209210103140.6888@utopia.booyaka.com>
 <20120921205322.GK28835@atomide.com>
 <20120921231039.GN28835@atomide.com>
 <alpine.DEB.2.00.1209220002290.6510@utopia.booyaka.com>
Message-ID: <20120922002111.GP28835@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120921 17:04]:
> On Fri, 21 Sep 2012, Tony Lindgren wrote:
> 
> > I tried merging this into tmp-merge, but ran into all kinds of
> > merge conflicts with the am33xx code etc and ended up with a
> > result that booted with all kinds of warnings on 2430sdp and
> > did not boot at all on zoom3 :) So I probably did something
> > wrong..
> > 
> > Care to base this on something more mergeable?
> 
> Just let me know what you want me to base it on.
> 
> > Maybe a merge of cleanup-fixes-for-v3.7 + omap-devel-am33xx-for-v3.7?
> 
> The series rebases cleanly onto cleanup-fixes-for-v3.7 + 
> omap-devel-am33xx-for-v3.7, so I guess you'll probably want me to base it 
> somewhere else?

Hmm I wonder what's causing it then? There must be something
else in tmp-merge at commit abfee61f that causes the problems.
Maybe try to merge with that commit and see what you get?

That commit can't be used as a base though as that's temporary
most likely.. But we can create a base to use out of the
branches once we know them, you can do it yourself too.

Regards,

Tony
