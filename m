From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 28 Feb 2011 11:18:53 +0100
Subject: [PATCH 6/8] ARM i.MX5: Allow to increase max zone order
In-Reply-To: <20110228100403.GA29843@n2100.arm.linux.org.uk>
References: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
	<1298887229-7987-7-git-send-email-s.hauer@pengutronix.de>
	<20110228100403.GA29843@n2100.arm.linux.org.uk>
Message-ID: <20110228101853.GH29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 10:04:03AM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 28, 2011 at 11:00:27AM +0100, Sascha Hauer wrote:
> > default setting of 11 allows us to allocate at maximum
> > 2MB chunks of contiguous memory. For resolutions up to
> > 1920x1080 32bpp we need much more memory, so make zone
> > order configurable
> 
> Wouldn't it be better to add another 'default' in there for ARCH_MX5
> rather than expecting whoever configures the kernel to be able to work
> out the right value?

We can skip this patch for now. I needed it when I was playing with full hd
resolutions, but I never got them to work anyway due to the lack of
hardware.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
