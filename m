From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Thu, 30 Oct 2014 00:31:04 +0200
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141029214541.GA21790@kahuna>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
 <20141028221243.GU2542@atomide.com> <5450EEE7.8070801@ti.com>
 <20141029185957.GA3723@earth.universe>
 <20141029193915.GB2542@atomide.com> <20141029214541.GA21790@kahuna>
Message-ID: <20141029223104.GA23366@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 04:45:41PM -0500, Nishanth Menon wrote:
> On 12:39-20141029, Tony Lindgren wrote:
> > OK, you want me to guess? A hundred million days, or maybe ten more
> > minutes, somewhere in there, I just can't say, don't know.
> 
> How about ~1 year? We have been talking about dt only boot for over an
> year already... Can we say 3.22 kernel, platforms that are not converted
> to device tree only loose legacy boot support. 

If you want to define some date, it should be a calendar date instead
of some kernel version based on guesswork (you cannot really predict
the kernel versions for future, just remember the 2.6.39 -> 3.0 change).

Also, you cannot expect all kernel users to know what you have been
talking about. E.g. OMAP DMA API deprecation may have been discussed
before, but I only learned it after the WARN appeared in the kernel tree.
So you should start counting from that.

Personally I don't mind if you delete OMAP3 legacy boot support already
tomorrow morning, but if you want to give ~1 year transition period it
should end somewhere in the end of 2015. Of course if there are no legacy
boot users you can do it faster.

A.
