From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 20 Jan 2016 19:25:19 +0200
Subject: [PATCH v6 1/2] ACPI: introduce a function to find the first
 physical device
In-Reply-To: <569FBD1A.5050609@linaro.org>
References: <1453300171-25473-1-git-send-email-aleksey.makarov@linaro.org>
 <1453300171-25473-2-git-send-email-aleksey.makarov@linaro.org>
 <CAHp75VcdtU6izThE+Z2ODnYoXk-uhweXzUtFwSze_jJHw3+38g@mail.gmail.com>
 <569FBD1A.5050609@linaro.org>
Message-ID: <CAHp75Vdedr9L_VPpbyKbDpqzheaovOh9bni_P5xyWH9djYFjoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 7:00 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> On 20.01.2016 21:12, Andy Shevchenko wrote:
>>
>> On Wed, Jan 20, 2016 at 4:29 PM, Aleksey Makarov
>> <aleksey.makarov@linaro.org> wrote:
>>>
>>> Factor out the code that finds the first physical device
>>> of a given ACPI device.  It is used in several places.
>>>
>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

For all your comments, I have to withdraw my tag. You may return it
back if Rafael and / or Mika will be okay with these changes.
Sorry for inconvenience.

>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>>
>>
>> Hmm? Sorry, didn't notice one style issue and there is one is matter
>> of taste below.

-- 
With Best Regards,
Andy Shevchenko
