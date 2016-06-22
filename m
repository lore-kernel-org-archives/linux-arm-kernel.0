From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 22 Jun 2016 15:05:52 +0530
Subject: [PATCH 1/2] cpufreq: exynos: use relaxed IO accesors
In-Reply-To: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160622093552.GD5458@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22-06-16, 10:33, Ben Dooks wrote:
> The use of __raw IO accesors is not endian safe and should be used
> sparingly. The relaxed variants should be as lightweight and also
> are endian safe.

I am not sure if exynos's code is required to be endian safe at all or
not, but this change wouldn't harm as well.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
