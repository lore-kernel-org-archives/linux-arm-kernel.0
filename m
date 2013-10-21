From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 21 Oct 2013 15:33:20 +0530
Subject: [PATCH 1/2] ARM: dts: omap5-uevm: remove always_on, boot_on from
 smps10_out1
In-Reply-To: <526043E3.3070302@baylibre.com>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
 <525E9206.9010501@ti.com> <525E9434.1090006@ti.com>
 <526043E3.3070302@baylibre.com>
Message-ID: <5264FBE8.4070704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 October 2013 01:39 AM, Benoit Cousson wrote:
> Hi Kishon,
> 
> On 16/10/2013 15:27, Nishanth Menon wrote:
>> On 10/16/2013 08:17 AM, Kishon Vijay Abraham I wrote:
>>> Benoit,
>>>
>>> On Thursday 10 October 2013 04:19 PM, Kishon Vijay Abraham I wrote:
>>>> smps10 should be enabled only in the case of host mode. So stop
>>>> doing always_on, boot_on from smps10_out1. The driver will enable it in host
>>>> mode.
>>>
>>> Can you take this patch too?
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
> 
> I've just applied it.

Thanks :-)

-Kishon
> 
> Thanks,
> Benoit
> 
> 
