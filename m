From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Sep 2015 14:08:06 +0530
Subject: cpufreq: mediatek: allow modular build
In-Reply-To: <3071823.f1VzTWVMmV@wuerfel>
References: <1768766.yu1lxjsjLL@wuerfel> <2329563.MhTbBXHVz1@wuerfel>
 <20150911082536.GL9650@linux> <3071823.f1VzTWVMmV@wuerfel>
Message-ID: <20150911083806.GM9650@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-09-15, 10:36, Arnd Bergmann wrote:
> I don't consider that a bug: a module with just an init function and
> no exit function can be loaded once and never unloaded, which is not
> nice for debugging, but is otherwise fully functional.

For me, there are two essential things that a module has to support:
- hotplug, which is just fine.
- hot-unplug, which will pass as well, but without freeing resources..

:)

-- 
viresh
