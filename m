From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Sep 2015 15:10:03 +0530
Subject: cpufreq: mediatek: allow modular build
In-Reply-To: <20150911093454.GK21084@n2100.arm.linux.org.uk>
References: <1768766.yu1lxjsjLL@wuerfel> <2329563.MhTbBXHVz1@wuerfel>
 <20150911082536.GL9650@linux> <3071823.f1VzTWVMmV@wuerfel>
 <20150911083806.GM9650@linux>
 <20150911093454.GK21084@n2100.arm.linux.org.uk>
Message-ID: <20150911094003.GN9650@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-09-15, 10:34, Russell King - ARM Linux wrote:
> Well, that's got nothing to do with not having a module_exit().

Yeah, so we don't necessarily need a module_exit(), but the module
should have freed the resources with module unplug. And that was
missing with Arnd's patch..

Or did I misinterpret your comment ?

-- 
viresh
