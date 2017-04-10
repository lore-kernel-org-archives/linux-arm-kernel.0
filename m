From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 10 Apr 2017 12:18:51 +0530
Subject: [PATCH] PM / OPP: Use - instead of @ for DT entries
In-Reply-To: <CAJKOXPe_+Y+9ZLE7Jymqc5nULzo+qM4cCMFg2-cV_YnpCFkRCA@mail.gmail.com>
References: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
 <20170410062258.GA24555@vireshk-i7>
 <CAK7LNAR=+k6iuqUPUNLW=EHUuOw4fBr4SbEtP-jnSyrsiEydgg@mail.gmail.com>
 <20170410063239.GB24555@vireshk-i7>
 <CAJKOXPe_+Y+9ZLE7Jymqc5nULzo+qM4cCMFg2-cV_YnpCFkRCA@mail.gmail.com>
Message-ID: <20170410064851.GC24555@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-04-17, 08:45, Krzysztof Kozlowski wrote:
> Yes, keeping both make most sense, I think.
> 
> Anyway, I found now the original report thread of Masahiro and I see
> Mark's response about using '-'. In that case I am fine with this. I
> would prefer to take only the exynos part (separated to ARMv7 and
> ARMv8) through my tree but I already sent a pull request so I am fine
> with this going directly to arm-soc.

This may end up going via the PM tree.

> I think you need to update also:
> Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt

Oops. I searched for opp@ and missed the complex ones. There are some
DT files as well for TI which I missed. Will send a V2 with all that
fixed.

> With that change:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> (and implied acked-by)

Thanks.

-- 
viresh
