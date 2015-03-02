From: vigneshr@ti.com (R, Vignesh)
Date: Mon, 2 Mar 2015 13:27:46 +0530
Subject: [PATCH 2/2] w1: masters: omap_hdq: Add support for 1-wire mode
In-Reply-To: <4111301.XAv3eRBo5S@wuerfel>
References: <1425029057-5075-1-git-send-email-vigneshr@ti.com>
 <10805905.OnX7kRTk9d@wuerfel> <54F04767.5070001@ti.com>
 <4111301.XAv3eRBo5S@wuerfel>
Message-ID: <54F417FA.1010802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On 2/27/2015 4:04 PM, Arnd Bergmann wrote:
> On Friday 27 February 2015 16:01:03 Vignesh R wrote:
>> On Friday 27 February 2015 03:25 PM, Arnd Bergmann wrote:
>>> On Friday 27 February 2015 14:54:17 Vignesh R wrote:
>>>> +- compatible : should be "ti,omap3-1w" or "ti,am43xx-hdq"
>>>>
>>>
>>> Do not use wildcards in the compatible string, use real part numbers
>>> if you don't know the actual name of the device.
>>
>>
>> The DT node for hdq on AM437x is already present in mainline
>> (commit: 741cac5f00beb) and it declares compatibility as
>> "ti,am43xx-hdq". Hence, I cannot change into anything different.
>>
> 
> No, there is no driver using this device, and the binding was
> not documented, so there is no problem in changing it: nobody
> will notice a regression when it was never working before

Ok... I will change it to "ti,am4372-hdq"

Regards
Vignesh
