From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 30 Jun 2015 11:20:43 +0200
Subject: [PATCH 01/41] clocksource: asm9260: Migrate to new 'set-state'
 interface
In-Reply-To: <20150630090048.GA4626@linux>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <57ae9434bbb7218961c3ad45a26fbe1fffe40cbd.1434622147.git.viresh.kumar@linaro.org>
 <55925268.4050109@linaro.org> <20150630090048.GA4626@linux>
Message-ID: <55925F6B.1010006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2015 11:00 AM, Viresh Kumar wrote:
> On 30-06-15, 10:25, Daniel Lezcano wrote:
>> Could you add in the changelog the subtle change with
>> set_mode(RESUME) and this code. As a default the timer was stopped
>> when entering in the set_mode function, now with the new API, this
>> is done explicitly.
>
>> Can you replace this line with a call to asm9260_timer_shutdown ?
>
> How does this look ?

Looks good to me.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
