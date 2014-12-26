From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 26 Dec 2014 17:58:51 +0100
Subject: [PATCH v2 6/6] arm: pxa: Transition pxa27x to clk framework
In-Reply-To: <2303917.o2xPYRxhCJ@avalon> (Laurent Pinchart's message of "Fri,
 26 Dec 2014 11:56:33 +0200")
References: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
 <1405353263-13424-7-git-send-email-robert.jarzmik@free.fr>
 <2303917.o2xPYRxhCJ@avalon>
Message-ID: <8761cy73g4.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laurent Pinchart <laurent.pinchart@ideasonboard.com> writes:

> Hi Robert,
>
> What happened to this patch ? It looks like the rest of the series got merged, 
> but this one seems to be missing.

It got reverted, because there were 3 boards with a defconfig which required
that both pxa27x and pxa25x were ported to common clock framework. As at that
time I had not ported pxa25x, I had to revert this one.

But now the situation is brighter. pxa25x was ported, tested, and merged by
Mike..Linus, so I can enable again common clock framework for both pxa27x and
pxa25x.

Actually it's good you make me think of it, as I've had the "pxa25x + pxa27x
common clocks enabler" patch in my local development tree for some time but I
didn't post it.

I'll post if for review this weekend I think.

Cheers.

--
Robert
