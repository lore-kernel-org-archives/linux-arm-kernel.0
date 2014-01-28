From: olof@lixom.net (Olof Johansson)
Date: Tue, 28 Jan 2014 10:36:51 -0800
Subject: [GIT PULL] ARM: mvebu: DT boards for v3.14 (incr #6)
In-Reply-To: <20140120200110.GW29184@titan.lakedaemon.net>
References: <20140120200110.GW29184@titan.lakedaemon.net>
Message-ID: <CAOesGMiTSa=ECDiVtgO44At9tqYCb2Ap8KWwG=FBStVEycqKcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 12:01 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> All,
>
> I had a few boards that came in late in the cycle.  I was holding on to
> them for the next round, but after Olof's comment this morning:
>
>   Re: [PATCH 0/2] DT updates for Hummingboard and new Cubox-i
>   http://www.spinics.net/lists/arm-kernel/msg301777.html
>
> I figured I'd send them off.  As usual, they've been in -next for a
> while.  Also, this is an incremental request from tags/mvebu-dt-3.14-5
> to tags/mvebu-dt-3.14-6 on the mvebu/dt branch.
>
> If this is going to be ok for the forseeable future, I'll do a separate
> branch for new boards next time around.

I should probably clarify my previous statement. I don't think we want
a free-for-all on new DT contents all the way up until -rc<lownumber>,
but what we can allow sometimes is new DT files when there's good
reason to do so -- for example for platforms where a lot of new code
has landed and it's been hard to sequence DT updates with the rest,
etc.

So, if you send these late requests please be prepared to motivate
them. :) These don't look urgent to me so I think we'll queue them for
3.15 once -rc1 is out, if that's OK with you.


-Olof
