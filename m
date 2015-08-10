From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Mon, 10 Aug 2015 09:55:09 -0700
Subject: [PATCH 42/74] clockevents/drivers/keystone: Migrate to new
 'set-state' interface
In-Reply-To: <1439200352-26767-42-git-send-email-daniel.lezcano@linaro.org>
References: <55C87382.4070309@linaro.org>
 <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
 <1439200352-26767-42-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <55C8D76D.9020503@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/10/15 2:51 AM, Daniel Lezcano wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
>
> Migrate keystone driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Also pass the mode-mask to keystone_timer_config() instead of the mode
> as mode macro's aren't valid anymore.
>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
