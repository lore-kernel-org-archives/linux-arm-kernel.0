From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Mon, 18 Nov 2013 17:15:12 +0200
Subject: Fwd: [PATCH 1/8] watchdog: davinci: change driver to use WDT core
In-Reply-To: <528A24DE.1010507@roeck-us.net>
References: <1383680783-12114-2-git-send-email-ivan.khoronzhuk@ti.com>
 <527A287C.2090401@ti.com> <5287D5A7.7060702@roeck-us.net>
 <5289FE60.2040207@ti.com> <528A24DE.1010507@roeck-us.net>
Message-ID: <528A2F00.7090302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 04:31 PM, Guenter Roeck wrote:
> On 11/18/2013 03:47 AM, ivan.khoronzhuk wrote:
>
>>>>    MODULE_LICENSE("GPL");
>>>> -MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
>>>>    MODULE_ALIAS("platform:watchdog");
>>>>
>>> You might want to rename the platform driver to something like
>>> davinci-wdt and change the MODULE_ALIAS
>>> accordingly.
>>>
>>
>> Yes, it could be changed but not in this patch.
>>
> Seems to me this would be the perfect time to change it, as you switch
> to use
> the watchdog core which permits more than one active watchdog in the
> system.
>
> Guenter
>

... Yes, you are right. I'll rename it.
-- 
Regards,
Ivan Khoronzhuk
