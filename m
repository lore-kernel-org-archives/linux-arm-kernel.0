From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 10 Dec 2015 00:53:41 +0100
Subject: [PATCH v2] cpufreq: mt8173: move resources allocation into
 ->probe()
In-Reply-To: <1449295306-9222-1-git-send-email-pi-cheng.chen@linaro.org>
References: <1448785898-17838-4-git-send-email-pi-cheng.chen@linaro.org>
 <1449295306-9222-1-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <3188378.Wlzx7Ukr89@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, December 05, 2015 02:01:46 PM Pi-Cheng Chen wrote:
> Since the return value of ->init() of cpufreq driver is not propagated
> to the device driver model now, move resources allocation into
> ->probe() to handle -EPROBE_DEFER properly.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>

I'm expecting a v3 here.  Please let me know if I should apply this instead.

Thanks,
Rafael
