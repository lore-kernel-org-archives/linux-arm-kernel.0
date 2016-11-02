From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 2 Nov 2016 18:47:53 +0100
Subject: [PATCH v7] spi: sun4i: Allow transfers larger than FIFO size
In-Reply-To: <20161027224712.GY25322@sirena.org.uk>
References: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
 <20161026085528.vjjypbfmfbhvileb@lukather>
 <20161027111419.GK25322@sirena.org.uk>
 <20161027212727.leqg3gvwhd3u64er@lukather>
 <20161027224712.GY25322@sirena.org.uk>
Message-ID: <20161102174753.elbukxnrc3x27xxc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Oct 27, 2016 at 11:47:12PM +0100, Mark Brown wrote:
> > > If the concern from the previous reviews to do with not using DMA is
> > > there some reason it's hard to do DMA?
> 
> > I think just like Alexandru that it is orthogonal. But to really
> > answer, no, it's not difficult. There's just been some fundamental
> > disagreement on whether DMA was supposed to be optional or not that
> > stalled everything I guess.
> 
> Oh, I seem to remember some patches adding DMA support that were doing
> some strange special snowflake thing with ignoring errors now that I
> think about it but that's not this one...  why did nobody ever follow up
> on those?

I have no idea. I think last time we discussed this was last
July. Especially with this in now, there's probably no rush anyway.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161102/b6ac813a/attachment.sig>
