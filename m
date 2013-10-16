From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 16 Oct 2013 15:36:18 +0200
Subject: [PATCH] ARM: highbank: cpuidle: convert to platform driver
In-Reply-To: <52457F21.3030502@linaro.org>
References: <1380278865-27457-1-git-send-email-daniel.lezcano@linaro.org>
 <CAL_Jsq+PoqWf5oAQosPg8N0WWHm-7c+JgDzpGD8OfMyKtvPJ0w@mail.gmail.com>
 <52457F21.3030502@linaro.org>
Message-ID: <525E9652.6060103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2013 02:50 PM, Daniel Lezcano wrote:
> On 09/27/2013 02:29 PM, Rob Herring wrote:
>> On Fri, Sep 27, 2013 at 5:47 AM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>> As the ux500 and the kirkwood driver, make the calxeda driver a
>>> platform driver
>>>
>>> [Compiled only]
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>   arch/arm/mach-highbank/highbank.c |    8 ++++++++
>>>   drivers/cpuidle/cpuidle-calxeda.c |   18 ++++++++++++------
>>>   2 files changed, 20 insertions(+), 6 deletions(-)
>>
>> Looks fine to me, but this will conflict with my series. Perhaps I can
>> pick this up as part of that.
>
> Yes I agree, it makes sense.

Hi Rob,

were you able to take the patch ? Where is the higbank git tree where I 
can see these patches ? I looked at 
git://sources.calxeda.com/kernel/linux.git #fox-next but they don't 
appear, is it the right one ?

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
