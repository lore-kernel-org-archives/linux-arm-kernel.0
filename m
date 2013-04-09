From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 9 Apr 2013 08:59:16 +0200
Subject: [PATCH] ARM i.MX53: remove platform ahci support
In-Reply-To: <1365451383.1830.135.camel@x61.thuisdomein>
References: <1365431039.1830.102.camel@x61.thuisdomein>
 <1365450363-6582-1-git-send-email-s.hauer@pengutronix.de>
 <1365451383.1830.135.camel@x61.thuisdomein>
Message-ID: <20130409065916.GY1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 10:03:03PM +0200, Paul Bolle wrote:
> On Mon, 2013-04-08 at 21:46 +0200, Sascha Hauer wrote:
> > Paul, with this one applied you could also remove config ARCH_MX53.
> 
> Unless I'm doing something wrong, this doesn't apply onto v3.9-rc6. I
> guess it requires some other branch. But, assuming I don't get fed up
> with cleaning up Kconfig cruft, I will notice ARCH_MX53 getting unused
> when your patch hits mainline anyway.

I wanted to say that the patch could be extended with more cleanup.

> 
> But is there a reason you can't just remove ARCH_MX53 yourself?

Just did that.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
