From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 25 Nov 2010 08:55:35 +0100
Subject: [PATCH v7 05/11] OMAP2420: hwmod data: Add GPIO
In-Reply-To: <AANLkTimRK=eKBG3pqGN8Ota5EO8EdmEibQN5C3Lwfheq@mail.gmail.com>
References: <1290524213-395-1-git-send-email-charu@ti.com>
	<1290524213-395-6-git-send-email-charu@ti.com>
	<4CED8DF7.6040606@ti.com>
	<AANLkTimRK=eKBG3pqGN8Ota5EO8EdmEibQN5C3Lwfheq@mail.gmail.com>
Message-ID: <4CEE1677.8030109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2010 5:36 AM, Varadarajan, Charulatha wrote:
> Benoit,
>
> On Thu, Nov 25, 2010 at 03:43, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> On 11/23/2010 3:56 PM, Varadarajan, Charulatha wrote:
>>>
>>> Add GPIO hwmod data for OMAP2420
>>>
>>> Signed-off-by: Charulatha V<charu@ti.com>

[...]

>>> diff --git a/arch/arm/plat-omap/include/plat/gpio.h
>>> b/arch/arm/plat-omap/include/plat/gpio.h
>>
>> That change should not necessarily be there, it is not directly related to
>> the subject.
>>
>> Maybe that should be in an extra patch just before that one.
>
> I merged these two patches because of a comment to introduce
> new variables/structures only in the patch where they are used.
> Since "omap_gpio_dev_attr" is being used by hwmod DB I merged
> these two patches. Do you think that hwmod DB patches should not
> be merged with other patches?

Not necessarily, maybe you can just update the changelog and the subject 
to indicate that you add a new structure as well in this patch.

Benoit
