From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 13 Dec 2010 09:45:46 +0100
Subject: [PATCH v3 5/5] OMAP: mailbox: add omap_device latency information
In-Reply-To: <AANLkTi=cQVr-T1mJeq9uaRn5VyXxBG-xcp79z898E6nx@mail.gmail.com>
References: <1292032266-29460-1-git-send-email-omar.ramirez@ti.com>	<1292032266-29460-6-git-send-email-omar.ramirez@ti.com>
	<AANLkTi=cQVr-T1mJeq9uaRn5VyXxBG-xcp79z898E6nx@mail.gmail.com>
Message-ID: <4D05DD3A.2050807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2010 4:25 PM, Ramirez Luna, Omar wrote:
> On Fri, Dec 10, 2010 at 7:51 PM, Omar Ramirez Luna<omar.ramirez@ti.com>  wrote:
>> From: Felipe Contreras<felipe.contreras@gmail.com>
>>
>> So that we can enable the main clock.
>
> This should be:
>
> Subject: OMAP: mailbox: use runtime pm for clk and sysc handling
>
> Use runtime pm APIs to enable/disable mailbox clocks and to configure
> SYSCONFIG registers.
>
> And if someone agrees, device_latency can be merged with the previous
> patch for device_build. I'll wait for comments and resubmit.

Yes, you're right, the device latency has nothing to do in that patch. 
It should be in the previous patch: [PATCH v3 4/5] OMAP: mailbox: build 
device using omap_device/omap_hwmod.

regards,
Benoit
