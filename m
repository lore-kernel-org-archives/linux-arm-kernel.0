From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 22:34:02 -0700
Subject: [GIT PULL] pxa dt binding for v3.12
In-Reply-To: <87haetfag9.fsf@kernel.org>
References: <CAN1soZx5Ax1jq3psJXwnHozBP6jA9Y3ziRL=go=bP5k2ds=thg@mail.gmail.com>
 <87haetfag9.fsf@kernel.org>
Message-ID: <20130814053402.GE16635@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 04:16:38PM -0700, Kevin Hilman wrote:
> Haojian Zhuang <haojian.zhuang@gmail.com> writes:
> 
> > Hi Olof & Arnd,
> 
> I'm also helping out with arm-soc maintenance now.  In the future,
> please be sure to Cc arm at kernel.org on pull requests for ease of
> filtering, so we don't miss anything.
> 
> > Here's the pull request from pxa git tree.
> 
> Pulled into next/dt.
> 
> In the future, it makes things simpler for us if you base on older -rc
> releases wherever possible (c.f. similar request by Olof[1].)  In this
> case, it was trivial for me to rebase it onto -rc1 so I've done that
> before applying.

We talked about this over IRC, but just for others education: Be careful when
you rebase, since platform maintainers have downstream users too, and some of
their trees are in linux-next. PXA isn't included there so this seemed ok to
do.

This is something we might want to bring up at the arm summit, I'll think about
it a bit more and propose a topic on the list.


-Olof
