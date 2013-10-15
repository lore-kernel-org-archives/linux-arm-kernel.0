From: bcousson@baylibre.com (Benoit Cousson)
Date: Tue, 15 Oct 2013 08:53:22 +0200
Subject: [PATCH 1/1] ARM: dts: omap3: Adapt USB OTG to generic PHY
 framework
In-Reply-To: <525BB74B.2040702@ti.com>
References: <1381152493-28055-1-git-send-email-rogerq@ti.com>
 <1381152493-28055-2-git-send-email-rogerq@ti.com>
 <20131010153427.GI28375@radagast> <525BB74B.2040702@ti.com>
Message-ID: <525CE662.3000704@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On 14/10/2013 11:20, Roger Quadros wrote:
> Hi Benoit,
>
> On 10/10/2013 06:34 PM, Felipe Balbi wrote:
>> On Mon, Oct 07, 2013 at 04:28:13PM +0300, Roger Quadros wrote:
>>> The generic PHY framewrok expects different properties than the
>>> old USB PHY framework. Supply those properties.
>>>
>>> Fixes USB OTG port on GAT04 and N900 after the Generic PHY framework was
>>> merged in greg/usb-next. [1]
>>>
>>> [1] - https://lkml.org/lkml/2013/9/27/581
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>
>> Acked-by: Felipe Balbi <balbi@ti.com>
>>
>
> Could you please pick this one for 3.13? Thanks.
>
> I don't see it in your 3.13 take 2 pull request.

It was not in it. I've just applied it.

Thanks
Benoit

-- 
Beno?t Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
