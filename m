From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 06 Nov 2013 00:38:19 +0100
Subject: [PATCH 0/2] More Allwinner SoC timer fixes
In-Reply-To: <1382699771-4396-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1382699771-4396-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <5279816B.90808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2013 01:16 PM, Maxime Ripard wrote:
> Hi,
>
> Here are more fixes to the sun4i timer that we spotted during the review of the
> High Speed timers patches, and that we hunted down during the Kernel Summit.
>
> Since they are not critical fixes for the current code we have, it doesn't have
> to be merged in 3.12 and can wait.
>
> Thanks!
> Maxime
>
> Maxime Ripard (2):
>    clockevent: sun4i: Fill the irq field in the clockevent structure
>    clocksource: sun4i: change CPU mask to cpu_possible_mask
>
>   drivers/clocksource/sun4i_timer.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>

Hi Maxime,

just a head up to tell I have been very busy last week for the Linaro 
connect. I will take care of the patches tomorrow.

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
