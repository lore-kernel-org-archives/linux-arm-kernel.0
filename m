From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Aug 2018 10:35:28 +0100
Subject: [PATCH v2 0/7] tda998x: allow use with bridge based devices
In-Reply-To: <59eeb1c4-163c-4fda-d51e-27f2f404fe3e@axentia.se>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
 <73adc630-21cd-5b14-cb47-f1a58ee3bc83@axentia.se>
 <20180731074114.GF17271@n2100.armlinux.org.uk>
 <9d48e374-be2f-fbc0-ca92-1b7e1b68e358@axentia.se>
 <20180731092343.GH17271@n2100.armlinux.org.uk>
 <9bf5e0e9-c1e8-5af2-7fea-40f9618d4d52@axentia.se>
 <20180731111537.GJ17271@n2100.armlinux.org.uk>
 <59eeb1c4-163c-4fda-d51e-27f2f404fe3e@axentia.se>
Message-ID: <20180801093528.GC30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2018 at 11:01:12AM +0200, Peter Rosin wrote:
> I don't think it's a problem with the atmel I2C driver. IIRC, the
> tda998x driver issues the command a initiate the EDID read, but that
> times out. So it appears to be the TDA19988 that fails to read the
> EDID over the DDC bus? Which brings me to the double problem with the
> scopes mentioned above...

It sounds like it.

It may be helpful to know that there are HDMI pass-through boards
available that give access to all the HDMI signals:

https://elabbay.myshopify.com/collections/camera
https://elabbay.myshopify.com/collections/camera/products/hdmi-af-af-v1a-hdmi-type-a-female-to-hdmi-type-a-male-pass-through-adapter-breakout-board

I've never bought from them, so please don't take this as a
recommendation - the fact that there seems to be no company details
on their site doesn't seem good, and as the whois for elabbay.com is
obscured also doesn't give me any confidence to buy from them.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
