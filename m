From: marex@denx.de (Marek Vasut)
Date: Mon, 4 Jan 2016 01:37:57 +0100
Subject: [PATCH] doc: PCI: altera: Fix the 'ranges' property in example
In-Reply-To: <1451866213.3051.16.camel@ubuntu>
References: <1450950330-28393-1-git-send-email-marex@denx.de>
 <201601040036.55446.marex@denx.de> <1451866213.3051.16.camel@ubuntu>
Message-ID: <201601040137.57271.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 04, 2016 at 01:10:13 AM, Ley Foon Tan wrote:

Hi!

> > > > Well, do you have a good explanation why the system works with this
> > > > change and doesn't work without it on my design ? I'd really love to
> > > > understand this.
> > > 
> > > Do you modify the driver to setup the translation table?
> > 
> > No, I didn't change the driver. What do you refer to please ?
> 
> There is Address Translation Table at address offset 0x1000 in the IP.

Oh, I didn't configure that in any way. Should I or does the driver configure it 
in some way?

> Do you use the hardware design from the rocketboards.org or your own
> design?

I use the one from rocketboards, I just ported it over to the MCVEVK
(custom cyclone v soc board)

Best regards,
Marek Vasut
