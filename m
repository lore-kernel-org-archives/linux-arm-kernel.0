From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 27 Sep 2013 15:17:02 +0200
Subject: [PATCH] clockevent: exynos_mct: fix lockdep warning
In-Reply-To: <CACVXFVO=k-wJ2SrjVQ_k1JhtAOo0-rZ_M780rqGWCbKA8_1qBQ@mail.gmail.com>
References: <1380120578-17458-1-git-send-email-tom.leiming@gmail.com>	<5243823D.4040208@linaro.org>	<17472486.7GQJa9ux9F@amdc1227>
 <CACVXFVO=k-wJ2SrjVQ_k1JhtAOo0-rZ_M780rqGWCbKA8_1qBQ@mail.gmail.com>
Message-ID: <5245854E.5030600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2013 03:09 PM, Ming Lei wrote:
> On Thu, Sep 26, 2013 at 6:32 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>>
>> This is a fix that we may want to have, but it must be modified to take
>> my regression fix[1] into account.
>>
>> [1] clocksource: exynos_mct: Set IRQ affinity when the CPU goes online
>> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/22511/focus=23418
>
> OK, I will write and submit v1 against your patch.

Better you stick to

https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/

or you rebase it against the v3.12-rc3 when it goes out.

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
