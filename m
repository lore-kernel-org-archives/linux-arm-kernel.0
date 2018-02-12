From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Feb 2018 09:17:09 -0800
Subject: [PATCH 02/10] ARM: dts: omap: Remove "cooling-{min|max}-level"
 for CPU nodes
In-Reply-To: <65c21dd1f5299d624ddb0b5e607226d86f745e19.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <65c21dd1f5299d624ddb0b5e607226d86f745e19.1518166039.git.viresh.kumar@linaro.org>
Message-ID: <20180212171709.GB6364@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Viresh Kumar <viresh.kumar@linaro.org> [180209 00:59]:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> a CPU cooling device is found by referring to the cpufreq table instead.
> 
> Remove the unused properties from the CPU nodes.

It seem this patch needs to wait before we can apply, right?

Regards,

Tony
