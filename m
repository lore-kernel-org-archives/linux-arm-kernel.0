From: peda@axentia.se (Peter Rosin)
Date: Thu, 2 Aug 2018 08:06:10 +0200
Subject: [PATCH v2 0/7] tda998x: allow use with bridge based devices
In-Reply-To: <20180801093528.GC30658@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
 <73adc630-21cd-5b14-cb47-f1a58ee3bc83@axentia.se>
 <20180731074114.GF17271@n2100.armlinux.org.uk>
 <9d48e374-be2f-fbc0-ca92-1b7e1b68e358@axentia.se>
 <20180731092343.GH17271@n2100.armlinux.org.uk>
 <9bf5e0e9-c1e8-5af2-7fea-40f9618d4d52@axentia.se>
 <20180731111537.GJ17271@n2100.armlinux.org.uk>
 <59eeb1c4-163c-4fda-d51e-27f2f404fe3e@axentia.se>
 <20180801093528.GC30658@n2100.armlinux.org.uk>
Message-ID: <1ad8d087-40a8-7a00-31cf-c4d34a9a12fb@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-08-01 11:35, Russell King - ARM Linux wrote:
> On Wed, Aug 01, 2018 at 11:01:12AM +0200, Peter Rosin wrote:
>> I don't think it's a problem with the atmel I2C driver. IIRC, the
>> tda998x driver issues the command a initiate the EDID read, but that
>> times out. So it appears to be the TDA19988 that fails to read the
>> EDID over the DDC bus? Which brings me to the double problem with the
>> scopes mentioned above...
> 
> It sounds like it.
> 
> It may be helpful to know that there are HDMI pass-through boards
> available that give access to all the HDMI signals:
> 
> https://elabbay.myshopify.com/collections/camera
> https://elabbay.myshopify.com/collections/camera/products/hdmi-af-af-v1a-hdmi-type-a-female-to-hdmi-type-a-male-pass-through-adapter-breakout-board
> 
> I've never bought from them, so please don't take this as a
> recommendation - the fact that there seems to be no company details
> on their site doesn't seem good, and as the whois for elabbay.com is
> obscured also doesn't give me any confidence to buy from them.

I still will not be able to inspect the DDC bus between the TDA19988
and the buffer circuit (IP4786), but the gadget seems useful enough and
it's not a shitload of money. We'll see how long it takes for it to get
here...

Thanks for the pointer! Maybe :-)

Cheers,
Peter
