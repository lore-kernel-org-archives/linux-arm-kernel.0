From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 10 Aug 2011 11:00:00 +0530
Subject: [RFC/PATCH 00/14] dt: omap hwmod-dt binding and omap3 i2c1 dt
	support
In-Reply-To: <4E421687.1060409@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
	<4E421687.1060409@ti.com>
Message-ID: <CAC63_iTaeZ4Gh2V4t=fJB5BUzyfybeuaDXisgApagW0T5r2v0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 10:56 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On 8/9/2011 7:40 PM, G, Manjunath Kondaiah wrote:
>>
>> This is in continuation of patch series posted at:
>> http://lwn.net/Articles/451917/
>>
>> Patches from Kevin Hilman and others are consolidated along with this
>> series since it will be part of ongoing work of decoupling pdev from
>> omap_device.
>> [There is latest version posted which will be rebased later]
>>
>> Apart from the above, the major feature included in this series is
>> dt-hwmod binding and preparing omap hwmod framework for adapting omap
>> drivers to support omap dt after aligning with Grant Likely
>> <grant.likely@secretlab.ca>
>>
>> However, current hwmod-dt binding will be replaced with notifiers in
>> generic board file and hwmod device pointer will be scanned and attached
>> in notifier call.
>>
>> Used 3.0 stable kernel version for this patch series since latest mainline
>> was broken for beagle boot last week.
>>
>> git://git.secretlab.ca/git/linux-2.6.git
>> Branch: devicetree/test-3.0
>
> Is there a reason why these are based on devicetree/test-3.0 and
> not devicetree/test?

devicetree/test was broken last week since grant has pulled latest
mainline changes hence selected stable version.

-M

[...]
