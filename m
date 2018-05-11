From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 11 May 2018 13:19:54 +0200
Subject: [PATCH 2/2] arm64: dts: Add Mediatek SoC MT8183 and evaluation
 board dts and Makefile
In-Reply-To: <1526035267.13828.13.camel@mtksdaap41>
References: <1526019083-20237-1-git-send-email-erin.lo@mediatek.com>
 <1526019083-20237-3-git-send-email-erin.lo@mediatek.com>
 <860cba8a-3af8-31d6-ec3f-81706d2d998b@gmail.com>
 <1526035267.13828.13.camel@mtksdaap41>
Message-ID: <b2dfc052-bbf4-2154-985d-b1e2e7717cf4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/11/2018 12:41 PM, Erin Lo wrote:
> On Fri, 2018-05-11 at 10:36 +0200, Matthias Brugger wrote:
>>
>> On 05/11/2018 08:11 AM, Erin Lo wrote:
[...]
>>
>> I wonder if there aren't any other devices which can be supported out of the box.
>> I understand that for now we are missing the clock driver and the pinctrl
>> driver. Are you planning to submit them in the near future?
>>
>> I'm asking because I don't want to bloat the dts with boards that only can boot
>> to an initramfs with a serial console. Especially if there is no HW + datasheet
>> available for anyone in the community who wants to work on this.
>>
>> Regards,
>> Matthias
>>
>> Regards,
>> Matthias
> 
> 
> We have implement clock and pinctrl driver these days, and plan to
> submit them maybe next month.
> After that we will submit other drivers of MT8183 continuously.
> 

I'm happy to hear this. So in this case I'm fine with merging these once you
figured out the dt-bindings.

Thanks a lot,
Matthias
