From: peter@senient.com (Peter Morrow)
Date: Thu, 18 Jun 2015 15:25:24 +0100
Subject: ARMADA-XP cpu1 .. cpu3 does not come online
In-Reply-To: <20150618161245.56907a89@free-electrons.com>
References: <20150618123833.GA28005@t440.home>
 <20150618161245.56907a89@free-electrons.com>
Message-ID: <20150618142524.GB5323@t440.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, Jun 18, 2015 at 04:12:45PM +0200, Thomas Petazzoni wrote:
> Dear Peter Morrow,
> 
> On Thu, 18 Jun 2015 13:38:33 +0100, Peter Morrow wrote:
> 
> > Linux: 4.0.5
> > U-boot: v2015.04
> 
> So you're using the mainline U-Boot ? It's true that on our side,
> we're only using the U-Boot provided by Marvell. I personally never had
> the time to test the mainline U-Boot, so I have no idea what are the
> usual issues/pitfalls in terms of compatibility with the mainline
> kernel.

That's correct.  Latest u-boot supports the mv78460-db so I had hoped
to use mainline u-boot instead of the marvell supplied one.  I will
however give the marvell u-boot a go this afternoon.

Cheers,
Peter

> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
