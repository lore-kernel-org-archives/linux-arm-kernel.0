From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 25 May 2018 22:41:03 +0200
Subject: [PATCH] ARM: pxa3xx: enable external wakeup pins
In-Reply-To: <d8f98f9d-cfea-4859-9e76-2a8868c9ba67@zonque.org> (Daniel Mack's
 message of "Fri, 25 May 2018 22:23:38 +0200")
References: <20180524204046.21494-1-daniel@zonque.org>
 <87in7bwkmg.fsf@belgarion.home>
 <d8f98f9d-cfea-4859-9e76-2a8868c9ba67@zonque.org>
Message-ID: <87efhzwjs0.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> On Friday, May 25, 2018 10:22 PM, Robert Jarzmik wrote:
>> Daniel Mack <daniel@zonque.org> writes:
>>
>>> The PXA3xx SoCs feature dedicated pins for wakeup functionality. These pins
>>> have no alternate functions, so let's always enable them as wakeup source on
>>> DT enabled boards. The WAKEUP1 pin is only available on PXA320.
>>>
>>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> That looks correct. Is it tested on any board ?
>
> Yup, on a PXA303 based one.
Great.

Queued into pxa/for-next.

Cheers.

-- 
Robert
