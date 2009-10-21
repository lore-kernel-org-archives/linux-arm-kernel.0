From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 20 Oct 2009 20:58:13 -0400
Subject: [PATCH] ep93xx: add errata info about pwm outputs
In-Reply-To: <4ADE5C13.6000502@bluewatersys.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB8080@mi8nycmail19.Mi8.com>
	<4ADE5C13.6000502@bluewatersys.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901E2491F@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 20, 2009 5:56 PM, Ryan Mallon wrote:
>> The EP93xx User's guide has an error about the number of pwm
>> channels available in the various chips.  Add comments about
>> this in the driver since the guide will probably never get
>> updated.
>> 
>>   EP9301/02 only have pwm.1, pin PMWOUT is not on the chip
>>   EP9307 only has pwm.0, pin PWMOUT1 (EGPIO14) is not on the chip
>>   EP9312/15 have both pwm0 and pwm.1
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>> 

[snip]

> Is there an official errata for this that we can link to?

Not that I have found.  Cirrus is no longer developing the EP93xx so
it will probably never be "officially" listed in any errata.

I just ran across this when I was trying to locate the PWMOUT pin on
an EP9302 chip.

Regards,
Hartley
