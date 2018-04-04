From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 4 Apr 2018 10:48:02 +0100
Subject: [PATCH V2 1/2] cpufreq: scmi: Don't validate the frequency table
 twice
In-Reply-To: <442ecfd0a5bddf32c912c449b072d8a0139318fc.1522749887.git.viresh.kumar@linaro.org>
References: <cover.1522749887.git.viresh.kumar@linaro.org>
 <442ecfd0a5bddf32c912c449b072d8a0139318fc.1522749887.git.viresh.kumar@linaro.org>
Message-ID: <5ce48bce-4fcf-1e0a-6b78-f588fbf7e4a5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


(I have exact patches ready :), was on vacation)

On 03/04/18 11:07, Viresh Kumar wrote:
> The cpufreq core is already validating the CPU frequency table after
> calling the ->init() callback of the cpufreq drivers and the drivers
> don't need to do the same anymore. Though they need to set the
> policy->freq_table field directly from the ->init() callback now.
> 
> Stop validating the frequency table from scmi driver.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
