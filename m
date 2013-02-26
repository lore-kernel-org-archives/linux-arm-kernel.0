From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 26 Feb 2013 12:30:28 +0100
Subject: [PATCH 1/2] time : pass broadcast device parameter
In-Reply-To: <CAKohpomqooF6DzzzdUFByA0wDxQ3RuPne15a9Vy1sScKjZfeyA@mail.gmail.com>
References: <5123C299.3080005@linaro.org>
 <1361484083-5906-1-git-send-email-daniel.lezcano@linaro.org>
 <CAKohpomqooF6DzzzdUFByA0wDxQ3RuPne15a9Vy1sScKjZfeyA@mail.gmail.com>
Message-ID: <512C9CD4.50808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 09:45 AM, Viresh Kumar wrote:
> On 22 February 2013 03:31, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> The broadcast timer could be passed as parameter to the function
>> instead of using again tick_broadcast_device.evtdev which was
>> previously used in the caller function.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> I know you are going for another round with this patchset and was just
> trying v1.
> 
> I did my tests on ARM Vexpress - TC2, big.LITTLE Arch.
> 
> Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks Viresh for testing.

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
