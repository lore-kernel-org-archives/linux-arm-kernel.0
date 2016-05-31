From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 31 May 2016 08:27:15 +0200
Subject: pxa_defconfig runtime failures due to 'ARM: pxa: activate pinctrl
 for device-tree machines'
In-Reply-To: <574A0AD1.9000304@roeck-us.net> (Guenter Roeck's message of "Sat,
 28 May 2016 14:17:05 -0700")
References: <20160527202715.GA4841@roeck-us.net>
 <87a8jah9ok.fsf@belgarion.home> <574A0AD1.9000304@roeck-us.net>
Message-ID: <87vb1ueo8s.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter Roeck <linux@roeck-us.net> writes:

> On 05/28/2016 01:24 AM, Robert Jarzmik wrote:
>> Guenter Roeck <linux@roeck-us.net> writes:
>>
>>> Hi,
>> I'd rather say that pxa_defconfig doesn't work anymore on any legacy system.
>> Its first purpose was to ensure compilation coverage of all legacy pxa systems.
>> Its second one was to have a single kernel bootable on all legacy pxa systems.
>>
>> Therefore, would you tell me if the patch in [1] fixes your issue ?
>>
>
> Yes, it does. It is actually the workaround I deployed for my test builds,
> since I thought that the change was on purpose.

Good. Can I take that as a Tested-by ?

Cheers.

-- 
Robert
