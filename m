From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 11 Feb 2018 03:17:16 -0800
Subject: [PATCH v2 5/7] watchdog: mtk: allow setting timeout in devicetree
In-Reply-To: <1518335184.9025.43.camel@mtkswgap22>
References: <20180210091911.3644-1-marcus.folkesson@gmail.com>
 <20180210091911.3644-5-marcus.folkesson@gmail.com>
 <1518261002.9025.36.camel@mtkswgap22> <20180210124328.GB744@gmail.com>
 <20180210201207.GC744@gmail.com>
 <5449674d-2812-c9b5-9c06-af2fbfa72737@roeck-us.net>
 <1518335184.9025.43.camel@mtkswgap22>
Message-ID: <80a95963-7bd9-a350-d899-3b0cf2d646fc@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2018 11:46 PM, Sean Wang wrote:
> On Sat, 2018-02-10 at 17:52 -0800, Guenter Roeck wrote:
>> On 02/10/2018 12:12 PM, Marcus Folkesson wrote:
>>> Hello Sean,
>>>
>>> On Sat, Feb 10, 2018 at 01:43:28PM +0100, Marcus Folkesson wrote:
>>>> Hello Sean,
>>>>
>>>> On Sat, Feb 10, 2018 at 07:10:02PM +0800, Sean Wang wrote:
>>>>>
>>>>> Hi, Marcus
>>>>>
>>>>> The changes you made for dt-bindings and driver should be put into
>>>>> separate patches.
>>>>
>>>> I actually thought about it but chose to have it in the same patch because I
>>>> did not see any direct advantage to separating them.
>>>>
>>>> But I can do that.
>>>> I will come up with a v3 with this change if no one thinks differently.
>>>>
>>>
>>> When looking at the git log, I'm not that convinced it should be
>>> separate patches.
>>>
>>> For example, I found a4f741e3e157c3a5c8aea5f2ea62b692fbf17338 that is
>>> doing the exact same thing as this patch.
>>>
>>> There is plenty of patches that mixes the code change and dt bindings
>>> updates.
>>> Could it not be useful to overview both the implementation and
>>> dt-mapping change in one view?
>>>
>>> If you or anyone else still think it should be separated, please let me know and I will
>>> come up with a v3.
>>>
>>
>> If we were talking about something new, specifically new and unapproved DT bindings,
>> it should be separate patches. However, that is not the case here. The DT bindings
>> are well established. Sure, we could be pedantic and request a split into two
>> patches. However, the only benefit of that would be more work for the maintainers,
>> ie Wim and myself (including me having to send this e-mail). I don't really see
>> the point of that.
>>
>> I have already sent my Reviewed-by:, and I don't intend to withdraw it.
>>
> Hi, both
> 
> Sorry for that if I caused any inconvenience to you. I didn't really
> insist on if the patch is needed to split into two, which totally
> depends on whether dt maintainers like it.
> 
> The change for dt-binding is usually added as a split patch with
> dt-bindings as a prefix. This way I thought dt maintainers is not
> easy to miss those patches and also can give some useful feedback
> for them.
> 

With all the trouble this one-line change is making, I feel inclined to drop
the patch for this driver.

Guenter
