From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 21 Oct 2013 15:33:06 +0530
Subject: [PATCH v2 2/2] ARM: dts: omap5: Add dr_mode for dwc3
In-Reply-To: <526043BA.5040100@baylibre.com>
References: <52580F34.8030809@ti.com>
 <1381816199-7966-1-git-send-email-kishon@ti.com> <525E91D4.30509@ti.com>
 <526043BA.5040100@baylibre.com>
Message-ID: <5264FBDA.8040704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 October 2013 01:38 AM, Benoit Cousson wrote:
> Hi Kishon,
> 
> On 16/10/2013 15:17, Kishon Vijay Abraham I wrote:
>> Benoit,
>>
>> On Tuesday 15 October 2013 11:19 AM, Kishon Vijay Abraham I wrote:
>>> From: George Cherian <george.cherian@ti.com>
>>>
>>> Added dr_mode property in dwc3 and set its default mode to device.
>>> Currently dwc3 driver doesn't have support for OTG mode. So explicitly
>>> setting to peripheral even dwc3 is a OTG controller since OMAP5 has
>>> already got an EHCI host.
>>>
>>> Signed-off-by: George Cherian <george.cherian@ti.com>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Can you take this patch for 3.13?
> 
> I've just applied it.

Thanks :-)

-Kishon

> 
> Thanks,
> Benoit
> 
> 
