From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 15 Feb 2016 10:58:43 +0530
Subject: [next] Odroid XU3 easily over-heats
In-Reply-To: <56C01963.3080106@gmail.com>
References: <56C01963.3080106@gmail.com>
Message-ID: <20160215052843.GA6334@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-02-16, 15:06, Krzysztof Kozlowski wrote:
> Hi all,
> 
> With recent addition of cpufreq-dt support to Exynos5422
> it is very easy to over-heat the Odroid XU3 leading to critical shutdown:

How were OPPs passed earlier? I failed to see them in kernel somehow.
You must have been using opp-v1 earlier, right?

You used boost-freqs then? You used cpufreq as a cooling device then?

> What about cpufreq as cooling device? Probably that part
> is missing now, right?

Maybe, how was that earlier though ?

-- 
viresh
