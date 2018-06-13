From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Jun 2018 16:33:43 -0700
Subject: [PATCH 1/5] ARM: dts: cygnus: Fix I2C controller interrupt type
In-Reply-To: <21124af0-f867-56a9-753d-cadfce7d1cf2@broadcom.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
 <1528834891-17807-2-git-send-email-ray.jui@broadcom.com>
 <8c368dbc-f654-ec52-0786-1f318156b8b5@gmail.com>
 <21124af0-f867-56a9-753d-cadfce7d1cf2@broadcom.com>
Message-ID: <fcb1d93a-3e1a-7020-a104-acc9360855e2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2018 04:32 PM, Ray Jui wrote:
> 
> 
> On 6/13/2018 12:49 PM, Florian Fainelli wrote:
>> On 06/12/2018 01:21 PM, Ray Jui wrote:
>>> Fix I2C controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
>>> Cygnus SoC
>>>
>>> Fixes: b51c05a331ff ("ARM: dts: add I2C device nodes for Broadcom
>>> Cygnus")
>>
>> This appears to be the only one that is truly needed here, the two
>> others below probably just moved things around but the offending commit
>> was already introduced in the above commit.
>>
> 
> Okay thanks. Will remove the other two "Fixes" below.

I can take care of that while applying the patches, no need for you to
resubmit, for the whole series I mean.

> 
>>> Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi
>>> bus")
>>> Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")
>>>
>>
>> There is no need for an extra line between the last Fixes: tag and your
>> Signed-off-by tag.
>>
> 
> Got it, thanks!

And that as well.
-- 
Florian
