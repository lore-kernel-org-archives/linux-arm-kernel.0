From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 27 Oct 2012 18:54:25 +0200
Subject: [PATCH] arm: mvebu: support for the Globalscale Mirabox MBX0001
 board
In-Reply-To: <20121027164448.GB15824@lunn.ch>
References: <1351354965-23875-1-git-send-email-gregory.clement@free-electrons.com>
 <20121027164448.GB15824@lunn.ch>
Message-ID: <20121027185425.40cabf8b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sat, 27 Oct 2012 18:44:48 +0200, Andrew Lunn wrote:
> > diff --git a/arch/arm/boot/dts/mbx001.dts b/arch/arm/boot/dts/mbx001.dts
> > new file mode 100644
> > index 0000000..88a5a11
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/mbx001.dts
> 
> Hi Gregory
> 
> Maybe it would be good to prefix this with armada-370. It then fits
> with armada-370-db.dts, and all the kirkwood files are kirkwood-*.dts.

So for OpenBlocks, I should rename armada-xp-openblocks-ax3-4.dts as
well, I guess. I agree with your comment: I think that a name such as
mbx001.dts is way too generic.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
