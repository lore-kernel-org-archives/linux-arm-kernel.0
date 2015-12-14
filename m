From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 15 Dec 2015 00:59:33 +0100
Subject: [PATCH v3] cpufreq: mt8173: move resources allocation into
 ->probe()
In-Reply-To: <1449719293-7966-1-git-send-email-pi-cheng.chen@linaro.org>
References: <3188378.Wlzx7Ukr89@vostro.rjw.lan>
 <1449719293-7966-1-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <1579627.P1F1zoisvS@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 10, 2015 11:48:13 AM Pi-Cheng Chen wrote:
> Since the return value of ->init() of cpufreq driver is not propagated
> to the device driver model now, move resources allocation into
> ->probe() to handle -EPROBE_DEFER properly.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied along with the [1-3] in this series.

Thanks,
Rafael
