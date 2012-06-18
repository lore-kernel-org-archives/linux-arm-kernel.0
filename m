From: stigge@antcom.de (Roland Stigge)
Date: Mon, 18 Jun 2012 19:15:46 +0200
Subject: [PATCH 1/2] sound: tegra_wm8903: Adjust to of_get_named_gpio()
 change
In-Reply-To: <20120618170408.GW3974@opensource.wolfsonmicro.com>
References: <1340037743-12924-1-git-send-email-stigge@antcom.de>
 <20120618164659.GV3974@opensource.wolfsonmicro.com>
 <4FDF5E9E.6060803@antcom.de>
 <20120618170408.GW3974@opensource.wolfsonmicro.com>
Message-ID: <4FDF6242.3040400@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 07:04 PM, Mark Brown wrote:
> On Mon, Jun 18, 2012 at 07:00:14PM +0200, Roland Stigge wrote:
> 
>> Basically, yes. But this would mean that doing via gpio, we would
>> need to pull other stuff from the sound tree over to gpio to
>> build upon because "my" tegra_* sound patches won't apply to the
>> gpio branch currently.
> 
> Oh, yes.  Stephen's gone and reorganised all that code which means
> it's not a trivial merge.  Ho hum.  I'm happy to apply them if
> folks are comfortable with it, I guess ideally I'd be able to pull
> a branch with the gpio changes in and then apply on top of that.

Depending on what else changes will come via gpio for 3.6, maybe you
don't even need to merge gpio to sound?

Can you please coordinate between sound and gpio?

Thanks in advance!

Roland

PS: I'm posting a combined patch suitable for the sound subsystem.
Please tell me if you also need the gpiolib-of patch singled out.
