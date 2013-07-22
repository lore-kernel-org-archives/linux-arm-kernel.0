From: mpfj-list@newflow.co.uk (Mark Jackson)
Date: Mon, 22 Jul 2013 14:43:31 +0100
Subject: [PATCH 01/22] ARM: ux500: Remove '0x's from HREF v60+ DTS file
In-Reply-To: <20130722134107.GB26801@laptop>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <51ED26C6.6000004@newflow.co.uk> <20130722134107.GB26801@laptop>
Message-ID: <51ED3703.9060703@newflow.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/13 14:41, Lee Jones wrote:
> On Mon, 22 Jul 2013, Mark Jackson wrote:
> 
>> On 22/07/13 11:52, Lee Jones wrote:
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>  arch/arm/boot/dts/hrefv60plus.dts | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
>>> index 3d580d6..46fd8af 100644
>>> --- a/arch/arm/boot/dts/hrefv60plus.dts
>>> +++ b/arch/arm/boot/dts/hrefv60plus.dts
>>> @@ -26,7 +26,7 @@
>>>  
>>>  	soc {
>>>  		i2c at 80110000 {
>>> -			bu21013_tp at 0x5c {
>>> +			bu21013_tp at 5c {
>>
>> Just a query ... why this one .... ^^^ ...
>>
>>>  				reset-gpio = <&gpio4 15 0x4>;
>>
>> ... and not this one .................................. ^^^ ?
>>
>>>  			};
>>>  		};
>>>
>>
>> The same for all the other patches in this series.
>>
>> If this is by design, it might be worth mentioning why some are
>> removed and not others.
> 
> I can't explain why there seems to be inconsistencies between node
> names and the remaining properties. The best I can do is refer you to
> the documentation where you can see that this is the standard:
> 
> Documentation/devicetree/usage-model.txt
> and
> http://www.devicetree.org/Device_Tree_Usage

Ho, ho ... don't you just love "standards" !!
