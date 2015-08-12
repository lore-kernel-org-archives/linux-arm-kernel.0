From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Wed, 12 Aug 2015 16:39:46 +0000
Subject: [PATCH] ARM/EP93xx/timer: Migrate to new 'set-state' interface
In-Reply-To: <744dca162a7626694770a9f51457566a33c3e08f.1438852023.git.viresh.kumar@linaro.org>
References: <744dca162a7626694770a9f51457566a33c3e08f.1438852023.git.viresh.kumar@linaro.org>
Message-ID: <BN3PR0101MB10579524DEE61E49B8725469D07E0@BN3PR0101MB1057.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 06, 2015 2:11 AM, Viresh Kumar wrote:
> Migrate EP93xx driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
