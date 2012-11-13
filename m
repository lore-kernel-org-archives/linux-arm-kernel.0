From: joe@perches.com (Joe Perches)
Date: Tue, 13 Nov 2012 07:57:58 -0800
Subject: [PATCH v6 2/7] net: mvneta: driver for Marvell Armada 370/XP
 network unit
In-Reply-To: <20121113164658.03ae12f8@skate>
References: <1352818843-4457-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1352818843-4457-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <1352820622.24230.31.camel@joe-AO722> <20121113164658.03ae12f8@skate>
Message-ID: <1352822278.24230.36.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-11-13 at 16:46 +0100, Thomas Petazzoni wrote:
> On Tue, 13 Nov 2012 07:30:22 -0800, Joe Perches wrote:
> > On Tue, 2012-11-13 at 16:00 +0100, Thomas Petazzoni wrote:
> > > This patch contains a new network driver for the network unit of the
> > > ARM Marvell Armada 370 and the Armada XP. Both SoCs use the PJ4B
> > > processor, a Marvell-developed ARM core that implements the ARMv7
> > > instruction set.
> > 
> > This looks very clean to me.
> 
> Thanks!
> 
> With the below fixes, may I get your formal Acked-by on the driver
> patch?

Hi Thomas.

I'm not one that believe there's much value in acks.
I don't have a card, I didn't test it, so I don't
know that it works.

The code style/readability looks pretty good to me.

> > trivial:
> > some of the logging doesn't use terminating newlines.
> > You could use netdev_info
[]
> Thanks for those comments, I'll wait a bit to see if any other comment
> shows up before tomorrow, and I'll send a v7 with those issues fixed.

These trivialities aren't any kind of blocking issue.

Perhaps David will apply it as is and you could send
a follow up patch later.
