From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 15 Apr 2014 11:20:24 +0200
Subject: [PATCH] arm: allow all architectures to change max zone order
In-Reply-To: <20140414193549.GJ24070@n2100.arm.linux.org.uk>
References: <1370019744-7588-1-git-send-email-l.stach@pengutronix.de>
 <1397487962.4548.30.camel@weser.hi.pengutronix.de>
 <20140414193549.GJ24070@n2100.arm.linux.org.uk>
Message-ID: <1397553624.4574.6.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Am Montag, den 14.04.2014, 20:35 +0100 schrieb Russell King - ARM Linux:
> On Mon, Apr 14, 2014 at 05:06:02PM +0200, Lucas Stach wrote:
> > Russell, can you please take a look at this? Nobody else seems to care
> > about this and we have to carry it around as without it imx-drm is
> > broken for FullHD displays with a 32bpp framebuffer.
> 
> I intentionally decided to ignore it because of the argumentative
> description in it that implies that I'm stupid for not making this
> available everywhere.  So, it can wait a bit longer.
> 

I'm sorry, it wasn't my intention to imply anything personal here. The
last sentence in the commit message was just meant to say that I could
not think of a reason to restrict this to SHMOBILE.

Can we please get this back on a technical level? If there is anything
technically wrong with this patch, I would really like to know.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
