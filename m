From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 12 Nov 2013 10:39:44 +0200
Subject: [PATCH 0/2] DaVinci: GPIO: fixes
In-Reply-To: <5281C839.8070100@ti.com>
References: <1383893156-28010-1-git-send-email-prabhakar.csengg@gmail.com>
 <5280FB19.4020204@ti.com> <5281C839.8070100@ti.com>
Message-ID: <5281E950.5090506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On 11/12/2013 08:18 AM, Sekhar Nori wrote:
> On Monday 11 November 2013 09:13 PM, Grygorii Strashko wrote:
>> Hi Sekhar, Prabhakar Lad
>>
>> On 11/08/2013 08:45 AM, Prabhakar Lad wrote:> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>>>
>>> This patch series fixes gpio driver regestration
>>> and offset check for unbanked gpio.
>>>
>>> Lad, Prabhakar (2):
>>>     gpio: davinci: Fix a check for unbanked gpio
>>>     ARM: davinci: Fix number of resources passed to
>>>       davinci_gpio_register() call
>>
>> I've verified both patches - looks ok.
>> Patch 1 - restores unbanked GPIO IRQs functionality
>> Patch 2 - allows to register GPIO Platform devices and boot without issues.
>>
>> Could we move forward with these patches?
> 
> Prabhakar, both patches look good to me. Thanks for the fixes.
> 
> Also Grygorii, have you actually verified that the unbanked IRQ support
> works? Only DM365 uses it.

Yes, I've verified it, but on Keystone which has similar GPIO IP
which supports only unbanked IRQs.

> 
> What do I add for you? Tested-by: or Acked-by:

Reported-and-Reviewed-and-Tested-by: Grygorii Strashko <grygorii.strashko@ti.com> :P
^Up to you :), but if I understand things right "Acked-by:" included all above

Regards,
- grygorii
