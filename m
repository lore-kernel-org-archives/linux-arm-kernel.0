From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Jun 2015 17:50:54 +0200
Subject: [PATCH 5/6] clocksource: cs5535: Migrate to new 'set-state'
 interface
In-Reply-To: <9ea6d10fe6578199584a3a3620da9cb6db481a2d.1433768426.git.viresh.kumar@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
 <9ea6d10fe6578199584a3a3620da9cb6db481a2d.1433768426.git.viresh.kumar@linaro.org>
Message-ID: <5579AE5E.6070704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 03:40 PM, Viresh Kumar wrote:
> Migrate cs5535 driver to the new 'set-state' interface provided by
> the clockevents core, the earlier 'set-mode' interface is marked
> obsolete now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Cc: Andres Salomon <dilinger@queued.net>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
