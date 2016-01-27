From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Jan 2016 10:34:23 -0800
Subject: [PATCH 0/3] ARM: dts: cm-t335: add peripherals - part 2
In-Reply-To: <569F39E9.2070506@compulab.co.il>
References: <1451475695-26921-1-git-send-email-uri.mashiach@compulab.co.il>
 <569F39E9.2070506@compulab.co.il>
Message-ID: <20160127183423.GS19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uri Mashiach <uri.mashiach@compulab.co.il> [160119 23:41]:
> Gentle ping
> 
> On 12/30/2015 01:41 PM, Uri Mashiach wrote:
> >Add support for the following peripherals:
> >- CAN BUS
> >- Touchscreen
> >- Audio
> >
> >Uri Mashiach (3):
> >   ARM: dts: cm-t335: Add support for CAN bus
> >   ARM: dts: cm-t335: add touchscreen support
> >   ARM: dts: cm-t335: add audio support
> >
> >  arch/arm/boot/dts/am335x-cm-t335.dts | 116 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 116 insertions(+)

Sorry for the delay, I was waiting forv4.5-rc1 and have most fixes
out of the way first. Applying into omap-for-v4.6/dt.

Regards,

Tony
