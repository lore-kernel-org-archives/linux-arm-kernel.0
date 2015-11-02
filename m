From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 2 Nov 2015 15:57:33 +0100
Subject: [PATCH 19/22] clocksource/drivers/prcmu: Fix Kconfig and add
 COMPILE_TEST option
In-Reply-To: <CACRpkdZXZG499JmvVjQHrWP06kJTkGE=J+ZV4WGNn3WLvbsujg@mail.gmail.com>
References: <1446469011-22710-1-git-send-email-daniel.lezcano@linaro.org>
 <1446469011-22710-19-git-send-email-daniel.lezcano@linaro.org>
 <CACRpkdZXZG499JmvVjQHrWP06kJTkGE=J+ZV4WGNn3WLvbsujg@mail.gmail.com>
Message-ID: <563779DD.6090808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2015 03:40 PM, Linus Walleij wrote:
> On Mon, Nov 2, 2015 at 1:56 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>
>> Let the platform's Kconfig to select the clock instead of having a reverse
>> dependency from the driver to the platform options.
>>
>> Add the COMPILE_TEST option for the compilation test coverage.
>>
>> This change is debatable as the option itself in the Kconfig allows to
>> select the driver for the platform or not. This change will make the prcmu
>> timer always selected.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Please merge this into the clksrc tree.

Thanks for the review.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
