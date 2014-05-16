From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 May 2014 15:09:59 -0400
Subject: [PATCH v6 00/15] enable HiP04 SoC
In-Reply-To: <40e13d6093a50fc81d77be607a00098f@www.loen.fr>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
 <14229972.j5k474Mq5Q@wuerfel>
 <CAD6h2NSpH0zxpek4KnUMT-p_DFnGZVaxP+x_0hsn1S8O6C7X6g@mail.gmail.com>
 <53748972.8040603@arm.com>
 <20140516050718.GZ27822@titan.lakedaemon.net>
 <40e13d6093a50fc81d77be607a00098f@www.loen.fr>
Message-ID: <20140516190959.GT27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 08:57:53AM +0100, Marc Zyngier wrote:
> Hi Jason,
> 
> >I've just started assisting Thomas with review / wrangling patches
> >for
> >drivers/irqchip. If you could Cc me on the next revision, I'd
> >appreciate
> >it.
> 
> That's excellent news! If you didn't have enough on your plate
> already, feel free to have a look at the GICv3 patches I reposted
> yesterday! :-)

During my first skim, I had noted to put Haojian in touch with you since
you were both working on GIC for >8 cores.  Then I saw you were already
there. :)

This is the first I've looked at irq-gic.c, (mvebu uses irq-orion.c and
irq-armada-370-xp.c) I'm going to try to bring myself up to speed this
weekend and then post some more thoughtful comments.

I know it sucks when you've reached v6 of a series and someone jumps in
out of the blue with changes and suggestions.  So I'll try to do it in
one go.  Like pulling off a band-aid.

thx,

Jason.
