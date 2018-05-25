From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 25 May 2018 19:30:12 +0200
Subject: i2c-gpio and boards conversions to GPIO descriptors
In-Reply-To: <20180525154144.GC19100@kw.sim.vm.gnt>
References: <20180525154144.GC19100@kw.sim.vm.gnt>
Message-ID: <20180525173012.GD19100@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 05:41:44PM +0200, Simon Guinot wrote:
> Hi Linus,

Forwarding to some mailing lists I missed in a first place.

> 
> I think your patch b2e63555592f "i2c: gpio: Convert to use descriptors"
> may have broken i2c-gpio support for some boards using old fashion
> platform_device declarations.
> 
> Indeed when an "i2c-gpio" platform_device is registered with a fixed id
> e.g. 0, then I think the device name becomes "i2c-gpio.0". And then this
> won't match a lookup table registered with an "i2c-gpio" dev_id.
> 
> Please double check this :)
> 
> Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180525/4bcae35d/attachment.sig>
