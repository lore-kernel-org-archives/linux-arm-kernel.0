From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 28 Nov 2013 11:34:06 +0530
Subject: [PATCH] watchdog: davinci: rename platform driver to davinci-wdt
In-Reply-To: <52961665.3060309@roeck-us.net>
References: <1385559113-4354-1-git-send-email-ivan.khoronzhuk@ti.com>
 <5295FB0E.4070406@ti.com> <52961665.3060309@roeck-us.net>
Message-ID: <5296DCD6.3030002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 November 2013 09:27 PM, Guenter Roeck wrote:
> On 11/27/2013 06:00 AM, Sekhar Nori wrote:
>> On Wednesday 27 November 2013 07:01 PM, Ivan Khoronzhuk wrote:
>>> As we switch to use the watchdog core which permits more than one
>>> active watchdog in the system, rename platform driver to
>>> "davinci-wdt" to be identifiable.
>>>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>
>> Looks good to me. Since bulk of this patch touches mach-davinci, I would
>> like to take this through my tree to avoid conflicts with other
>> mach-davinci patches I accept.
>>
> 
> Good idea, and makes sense.

Added to v3.14/soc with your Reviewed-by

Thanks,
Sekhar

[1]
https://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/log/?h=v3.14/soc
