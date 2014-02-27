From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu, 27 Feb 2014 10:16:05 +0100
Subject: [PATCHv2 14/16] ARM: OMAP3: hwmod data: cleanup data for IOMMUs
In-Reply-To: <530E2B67.9050300@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
 <1392315347-32967-15-git-send-email-s-anna@ti.com>
 <20140226171824.GH11654@atomide.com> <530E2B67.9050300@ti.com>
Message-ID: <530F0255.0@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/26/2014 06:59 PM, Suman Anna wrote:
> Tony,
> 
> On 02/26/2014 11:18 AM, Tony Lindgren wrote:
>> * Suman Anna <s-anna@ti.com> [140213 10:19]:
>>> From: Florian Vaussard <florian.vaussard@epfl.ch>
>>>
>>> The irq numbers, ocp address space and device attribute data
>>> have all been cleaned up for OMAP3 IOMMUs. All this data is
>>> populated via the corresponding dt node.
>>>
>>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>
>> This will need to wait until we've made omap3 to be DT only
>> as this will break idling of things for the legacy booting.
>>
> 
> OK, will drop this and I will adjust Patch 9 to support the legacy boot
> for OMAP3 ISP.
> 

BTW, Tony do you have a new window for omap3 to be DT onyl?

Regards,
Florian
