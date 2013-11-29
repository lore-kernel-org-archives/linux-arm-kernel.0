From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 29 Nov 2013 13:44:32 +0530
Subject: [PATCH] watchdog: davinci: rename platform driver to davinci-wdt
In-Reply-To: <52973E40.4060400@roeck-us.net>
References: <1385559113-4354-1-git-send-email-ivan.khoronzhuk@ti.com>
 <5295FB0E.4070406@ti.com> <52961665.3060309@roeck-us.net>
 <5296DCD6.3030002@ti.com> <52973E40.4060400@roeck-us.net>
Message-ID: <52984CE8.50803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wim,

On Thursday 28 November 2013 06:29 PM, Guenter Roeck wrote:
> On 11/27/2013 10:04 PM, Sekhar Nori wrote:
>> On Wednesday 27 November 2013 09:27 PM, Guenter Roeck wrote:
>>> On 11/27/2013 06:00 AM, Sekhar Nori wrote:
>>>> On Wednesday 27 November 2013 07:01 PM, Ivan Khoronzhuk wrote:
>>>>> As we switch to use the watchdog core which permits more than one
>>>>> active watchdog in the system, rename platform driver to
>>>>> "davinci-wdt" to be identifiable.
>>>>>
>>>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>>>
>>>> Looks good to me. Since bulk of this patch touches mach-davinci, I
>>>> would
>>>> like to take this through my tree to avoid conflicts with other
>>>> mach-davinci patches I accept.
>>>>
>>>
>>> Good idea, and makes sense.
>>
>> Added to v3.14/soc with your Reviewed-by
>>
> 
> You should get an Ack from Wim.

Can you please provide your ack? I will add it to the existing commit.

Thanks,
Sekhar
