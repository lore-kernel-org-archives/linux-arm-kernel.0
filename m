From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 31 Aug 2013 09:17:52 +0200
Subject: [PATCH v11 3/8] ASoC: generic: simple DT sound card
In-Reply-To: <20130823095816.GF25263@sirena.org.uk>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-4-git-send-email-mpa@pengutronix.de>
 <20130823095816.GF25263@sirena.org.uk>
Message-ID: <20130831071752.GX20071@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 23, 2013 at 10:58:16AM +0100, Mark Brown wrote:
> On Mon, Aug 19, 2013 at 05:05:56PM +0200, Markus Pargmann wrote:
> > Simple sound card initialized using DT. When used with AC97, ac97-codec
> > is used to automatically discover the used codec.
> 
> I've held back a bit on this one.  The reason is that it's adding a
> separate card to the generic card which doesn't seem like the obvious
> thing to do - obviously they have very similar goals, it's just that one
> is for DT usage and the other isn't.  What's the reason for not adding
> DT support to the generic card?

There was no code I could reuse from the existing simple card driver, so
I decided to seperate the DT part.

I will move the DT driver code into simple card and resend the patch.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
