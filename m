From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 31 May 2016 07:53:18 -0700
Subject: pxa_defconfig runtime failures due to 'ARM: pxa: activate pinctrl
 for device-tree machines'
In-Reply-To: <87vb1ueo8s.fsf@belgarion.home>
References: <20160527202715.GA4841@roeck-us.net>
 <87a8jah9ok.fsf@belgarion.home> <574A0AD1.9000304@roeck-us.net>
 <87vb1ueo8s.fsf@belgarion.home>
Message-ID: <574DA55E.7070109@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2016 11:27 PM, Robert Jarzmik wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
>
>> On 05/28/2016 01:24 AM, Robert Jarzmik wrote:
>>> Guenter Roeck <linux@roeck-us.net> writes:
>>>
>>>> Hi,
>>> I'd rather say that pxa_defconfig doesn't work anymore on any legacy system.
>>> Its first purpose was to ensure compilation coverage of all legacy pxa systems.
>>> Its second one was to have a single kernel bootable on all legacy pxa systems.
>>>
>>> Therefore, would you tell me if the patch in [1] fixes your issue ?
>>>
>>
>> Yes, it does. It is actually the workaround I deployed for my test builds,
>> since I thought that the change was on purpose.
>
> Good. Can I take that as a Tested-by ?
>
Yes.

Guenter
