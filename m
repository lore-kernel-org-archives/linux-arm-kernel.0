From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 20 Jul 2018 13:43:46 -0500
Subject: [PATCH] i2c: davinci: Avoid zero value of CLKH
In-Reply-To: <ab965f1d-de6c-75f7-9ebd-35d31ed3de18@ti.com>
References: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
 <ab965f1d-de6c-75f7-9ebd-35d31ed3de18@ti.com>
Message-ID: <0c29ccf5-4077-47a2-e7e0-c89ffcf8cb0b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/17/2018 06:57 AM, Sekhar Nori wrote:
> On Friday 13 July 2018 08:50 PM, Alexander Sverdlin wrote:
>> If CLKH is set to 0 I2C clock is not generated at all, so avoid this value
>> and stretch the clock in this case.
> 
> This must be by observation since specification does not seem to state
> this.

It will be good to know (mention) on what hw was it observed?

> 
>>
>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> In any case, the patch is fine.
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> 
[...]

-- 
regards,
-grygorii
