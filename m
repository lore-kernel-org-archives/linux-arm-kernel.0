From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 12 Oct 2011 10:16:26 +0200
Subject: [PATCHv9 03/18] TEMP: OMAP3xxx: hwmod data: add PRM hwmod
In-Reply-To: <alpine.DEB.2.00.1110101725140.5205@utopia.booyaka.com>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
	<1316781986-30642-4-git-send-email-t-kristo@ti.com>
	<alpine.DEB.2.00.1110101320180.5205@utopia.booyaka.com>
	<4E934D79.4080000@ti.com>
	<alpine.DEB.2.00.1110101416530.5205@utopia.booyaka.com>
	<4E936F0E.9050203@ti.com>
	<alpine.DEB.2.00.1110101725140.5205@utopia.booyaka.com>
Message-ID: <4E954CDA.10107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2011 1:26 AM, Paul Walmsley wrote:
> On Tue, 11 Oct 2011, Cousson, Benoit wrote:
>
>> In fact the device name does not have to match the hwmod name. So we can just
>> create an "omap2_prm" omap_device for OMAP2, "omap3_prm" omap_device for
>> OMAP3...
>> That will allow the relevant PRM  driver to be bound to the proper device.
>
> Incidentally, given that we would be using the hwmod name and the version
> number to determine the appropriate omap_device name, what IP version
> numbers should we assign to these PRM IP blocks for different SoCs?

It can just be 1, 2 and 3... The idea is just to differentiate the IP 
for each OMAP.

Regards,
Benoit
