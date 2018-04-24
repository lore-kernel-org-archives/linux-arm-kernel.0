From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 24 Apr 2018 11:39:22 +0530
Subject: [PATCH] cpufreq: add suspend/resume support in Armada 37xx DVFS
 driver
In-Reply-To: <20180423163843.2b9e18b2@xps13>
References: <20180421141943.25705-1-miquel.raynal@bootlin.com>
 <20180423042703.GC2989@vireshk-i7> <20180423163843.2b9e18b2@xps13>
Message-ID: <20180424060922.GE2989@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23-04-18, 16:38, Miquel Raynal wrote:
> How would you proceed then? Shall I continue in this path? I checked
> all the drivers currently registering the cpufreq-dt driver, none of
> them use this structure, so I am open to suggestions.

I have sent you a series, please test that one.

-- 
viresh
