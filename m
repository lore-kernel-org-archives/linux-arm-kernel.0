From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 30 Jun 2015 10:28:53 +0200
Subject: [PATCH 02/41] clocksource: cadence_ttc: Migrate to new 'set-state'
 interface
In-Reply-To: <effe1fbb8239a26043a7e7bc5340f9ddd9aabd81.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <effe1fbb8239a26043a7e7bc5340f9ddd9aabd81.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <55925345.8080207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2015 12:54 PM, Viresh Kumar wrote:
> Migrate cadence_ttc driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Sounds good.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
