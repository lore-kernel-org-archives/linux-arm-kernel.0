From: stefan.mavrodiev@gmail.com (Stefan Mavrodiev)
Date: Mon, 18 Dec 2017 13:00:51 +0200
Subject: [PATCH 1/1] arm: sunxi: Add alternative pins for spi0
In-Reply-To: <20171218092814.n5ptd5mhvo4nkjgq@flea.lan>
References: <1513151074-6888-1-git-send-email-stefan@olimex.com>
 <20171213154035.qc655iahjoeflftq@flea.lan>
 <5f518e4b-e624-17c2-7e72-24ba930a1c15@gmail.com>
 <20171215150823.jplgknururmkvp2t@flea.lan>
 <ca648552-cefb-e19d-72cf-8b56e97b013d@gmail.com>
 <20171218092814.n5ptd5mhvo4nkjgq@flea.lan>
Message-ID: <68c1f3e9-38f6-1654-f08f-c9a9c053c1d2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2017 11:28 AM, Maxime Ripard wrote:
> On Mon, Dec 18, 2017 at 08:24:21AM +0200, Stefan Mavrodiev wrote:
>> On 12/15/2017 05:08 PM, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Thu, Dec 14, 2017 at 08:24:54AM +0200, Stefan Mavrodiev wrote:
>>>> On 12/13/2017 05:40 PM, Maxime Ripard wrote:
>>>>> Hi,
>>>>>
>>>>> On Wed, Dec 13, 2017 at 09:44:34AM +0200, Stefan Mavrodiev wrote:
>>>>>> Allwinner A10/A13/A20 SoCs have pinmux for spi0
>>>>>> on port C. The patch adds these pins in the respective
>>>>>> dts includes.
>>>>>>
>>>>>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>>>>> Do you have any boards that are using these?
>>>>>
>>>>> We won't merge that patch if there's no users for it.
>>>> A20-OLinuXino-Lime/Lime2 and A10-OLinuXino-Lime with spi flash.
>>>> For A13 we still doesn't have that option.
>>> If this bus is exposed on the headers, you can add those to the DT but
>>> leave them disabled if you want. Buf if there's no users of those
>>> nodes, our policy is not to merge them.
>> So basically I should resend the patch, enabling the those pins only for
>> sun4i and sun7i platform?
> I'm not quite sure what you mean, but you should do something like
> 77df9d66b0b1ad01c685fd6341ce501493899658
>
> Maxime
>
I guess, since this patch actually supports optional component, it 
shouldn't be applied.
(This is already commented here: 
https://patchwork.kernel.org/patch/10076721/ )

Thanks,
Stefan Mavrodiev
