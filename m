From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 27 Sep 2013 14:50:41 +0200
Subject: [PATCH] ARM: highbank: cpuidle: convert to platform driver
In-Reply-To: <CAL_Jsq+PoqWf5oAQosPg8N0WWHm-7c+JgDzpGD8OfMyKtvPJ0w@mail.gmail.com>
References: <1380278865-27457-1-git-send-email-daniel.lezcano@linaro.org>
 <CAL_Jsq+PoqWf5oAQosPg8N0WWHm-7c+JgDzpGD8OfMyKtvPJ0w@mail.gmail.com>
Message-ID: <52457F21.3030502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2013 02:29 PM, Rob Herring wrote:
> On Fri, Sep 27, 2013 at 5:47 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> As the ux500 and the kirkwood driver, make the calxeda driver a platform driver
>>
>> [Compiled only]
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   arch/arm/mach-highbank/highbank.c |    8 ++++++++
>>   drivers/cpuidle/cpuidle-calxeda.c |   18 ++++++++++++------
>>   2 files changed, 20 insertions(+), 6 deletions(-)
>
> Looks fine to me, but this will conflict with my series. Perhaps I can
> pick this up as part of that.

Yes I agree, it makes sense.

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
