From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 4 Apr 2018 21:56:23 +0200
Subject: [PATCH 00/15] ARM: pxa: switch to DMA slave maps
In-Reply-To: <874lkq4urd.fsf@belgarion.home>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <CAPDyKFot9dAST2jQL5s8E4U=bCHxkio=uwpqPd6S0N4FWJRB-w@mail.gmail.com>
 <874lkq4urd.fsf@belgarion.home>
Message-ID: <20180404215623.2bf07406@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Apr 2018 21:49:26 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > On 2 April 2018 at 16:26, Robert Jarzmik <robert.jarzmik@free.fr> wrote:  
> >> Hi,
> >>
> >> This serie is aimed at removing the dmaengine slave compat use, and transfer
> >> knowledge of the DMA requestors into architecture code.
> >> As this looks like a patch bomb, each maintainer expressing for his tree either
> >> an Ack or "I want to take through my tree" will be spared in the next iterations
> >> of this serie.  
> >
> > Perhaps an option is to send this hole series as PR for 3.17 rc1, that
> > would removed some churns and make this faster/easier? Well, if you
> > receive the needed acks of course.  
> For 3.17-rc1 it looks a bit optimistic with the review time ... If I have all

Especially since 3.17-rc1 has been released more than 3 years ago :-),
but I guess you meant 4.17-rc1.

> acks, I'll queue it into my pxa tree. If at least one maintainer withholds his
> ack, the end of the serie (phase 3) won't be applied until it is sorted out.
> 
> Cheers.
> 
> --
> Robert
