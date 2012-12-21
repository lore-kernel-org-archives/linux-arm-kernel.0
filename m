From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 21 Dec 2012 13:43:25 +1100
Subject: [GIT PULL v2] ARM: arm-soc fixes for 3.8
In-Reply-To: <CA+55aFyiRPk0Qta35PBqMFqn+GkKaugqKJM3WHCT0JEJ1YohWw@mail.gmail.com>
References: <20121220163814.GA29557@quad.lixom.net>
 <20121220175639.GA14363@n2100.arm.linux.org.uk>
 <CAOesGMgxXmXUW2RP_5AxJ6Z5sRBhFJ2CQz4S12MwXAb3=ibYOA@mail.gmail.com>
 <20121220184525.GC21056@atomide.com>
 <CA+55aFyiRPk0Qta35PBqMFqn+GkKaugqKJM3WHCT0JEJ1YohWw@mail.gmail.com>
Message-ID: <1356057805.5397.58.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-12-20 at 11:00 -0800, Linus Torvalds wrote:
> Hmm. The patch there looks better than any alternative I can think of.
> It uses the same spinlock name for the whole array, but I think it's
> only used for lockdep printouts, so that should be fine.
> 
> Send me the patch with signed-off and tested-by, and perhaps have a
> few more people test it. The powerpc and sparc people both use it in
> their 32-bit versions and have responsible maintainers, so it might be
> worth it double-checking with BenH and DaveM about it, just in case.
> Added to the Cc.

The patch looks fine. I won't personally be able to test it until after
I'm back from vacation though. I'll see if I can get somebody else to
but don't wait for me.

Cheers,
Ben.
