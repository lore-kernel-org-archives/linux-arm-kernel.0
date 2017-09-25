From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 26 Sep 2017 01:35:20 +0200
Subject: [PATCH 0/3] clocksource: pr_err() strings should end with newlines
In-Reply-To: <1506327401-30521-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1506327401-30521-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <f46f1d66-9120-9be3-dd5f-fa26579730eb@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/2017 10:16, Arvind Yadav wrote:
> pr_err() messages should terminated with a new-line to avoid
> other messages being concatenated onto the end.
> 
> Arvind Yadav (3):
>   [PATCH 1/3] clocksource: fttmr010: pr_err() strings should end with newlines
>   [PATCH 2/3] clocksource: owl: pr_err() strings should end with newlines
>   [PATCH 3/3] clocksource: rockchip: pr_err() strings should end with newlines
> 
>  drivers/clocksource/owl-timer.c      | 4 ++--
>  drivers/clocksource/rockchip_timer.c | 2 +-
>  drivers/clocksource/timer-fttmr010.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Applied and slightly changed the commit log to:

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

In the future, please use the subject subsystem format to:

clocksource/drivers/<timer>: ....

Thanks.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
