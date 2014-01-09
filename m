From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 9 Jan 2014 16:42:43 +0530
Subject: [PATCH] watchdog: davinci: rename platform driver to davinci-wdt
In-Reply-To: <20140109110852.GA4898@spo001.leaseweb.com>
References: <1385559113-4354-1-git-send-email-ivan.khoronzhuk@ti.com>
 <5295FB0E.4070406@ti.com> <52961665.3060309@roeck-us.net>
 <5296DCD6.3030002@ti.com> <52973E40.4060400@roeck-us.net>
 <52984CE8.50803@ti.com> <52CE7F3F.1000201@ti.com>
 <20140109110852.GA4898@spo001.leaseweb.com>
Message-ID: <52CE842B.3080500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 January 2014 04:38 PM, Wim Van Sebroeck wrote:
> Hi Sekhar,
> 
>> On Friday 29 November 2013 01:44 PM, Sekhar Nori wrote:
>>> Wim,
>>>
>>> On Thursday 28 November 2013 06:29 PM, Guenter Roeck wrote:
>>>> On 11/27/2013 10:04 PM, Sekhar Nori wrote:
>>>>> On Wednesday 27 November 2013 09:27 PM, Guenter Roeck wrote:
>>>>>> On 11/27/2013 06:00 AM, Sekhar Nori wrote:
>>>>>>> On Wednesday 27 November 2013 07:01 PM, Ivan Khoronzhuk wrote:
>>>>>>>> As we switch to use the watchdog core which permits more than one
>>>>>>>> active watchdog in the system, rename platform driver to
>>>>>>>> "davinci-wdt" to be identifiable.
>>>>>>>>
>>>>>>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>>>>>>
>>>>>>> Looks good to me. Since bulk of this patch touches mach-davinci, I
>>>>>>> would
>>>>>>> like to take this through my tree to avoid conflicts with other
>>>>>>> mach-davinci patches I accept.
>>>>>>>
>>>>>>
>>>>>> Good idea, and makes sense.
>>>>>
>>>>> Added to v3.14/soc with your Reviewed-by
>>>>>
>>>>
>>>> You should get an Ack from Wim.
>>>
>>> Can you please provide your ack? I will add it to the existing commit.
>>
>> I never received an ack from Wim, but I am going to send this for
>> merging through ARM-SoC anyway. I will keep Wim copied on the pull
>> request so he knows.
> 
> This has my Ack. No issue with getting this through the ARM-SoC tree but bear in mind that there are allready other davinci pateches in the linux-watchdog-next tree+.

Okay. I will add you ack (I just applied my signed tag, grr).
I did a test merge of this patch with today's linux-next and see no
conflicts.

Thanks,
Sekhar
