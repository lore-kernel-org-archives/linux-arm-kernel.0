From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 29 May 2013 11:04:43 +0200
Subject: [PATCH v3 0/5] ARM: dts: OMAP2+: use preprocessor for device trees
In-Reply-To: <51A5C1FE.6020404@epfl.ch>
References: <1369666354-29152-1-git-send-email-florian.vaussard@epfl.ch>
 <51A46DB0.5020508@epfl.ch> <51A5C068.9040308@ti.com>
 <51A5C1FE.6020404@epfl.ch>
Message-ID: <51A5C4AB.2060209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2013 10:53 AM, Florian Vaussard wrote:
> Hello Benoit,
> 
> On 05/29/2013 10:46 AM, Benoit Cousson wrote:
>> Salut Florian,
>>
>> On 05/28/2013 10:41 AM, Florian Vaussard wrote:
>>>
>>> On 05/27/2013 04:52 PM, Florian Vaussard wrote:
>>>> Hello,
>>>>
>>>> Following a similar proposal by Stephen Warren for tegra [1], this
>>>> series
>>>> makes use of the C preprocessor when compiling OMAP DT files, and
>>>> accomplishes some improvements to improve overall readability.
>>
>> Thanks for that nice cleanup.
>>
>>> I realized that I should also address am* devices. I will wait for
>>> comments
>>> on this version, then post a v4. Sorry for the noise.
>>
>> That's up to you, but I can anyway already pulled that series. That AM*
>> patches can go later.
>>
> 
> I saw in your for_3.11/dts branch that you have a couple of patches
> declaring
> new pinctrl bindings, so I should base my series of this branch to address
> these patches as well. So I will send a v4 anyway in the coming days.

OK, no problem. I'll wait for the update.

Regards,
Benoit
