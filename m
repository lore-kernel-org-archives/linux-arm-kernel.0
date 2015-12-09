From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 9 Dec 2015 08:28:41 +0530
Subject: [PATCH v5 09/11] cpufreq: st: Provide runtime initialised driver
 for ST's platforms
In-Reply-To: <20151209025719.GV3692@ubuntu>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
 <1449585124-15596-10-git-send-email-lee.jones@linaro.org>
 <20151209025719.GV3692@ubuntu>
Message-ID: <20151209025841.GW3692@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-12-15, 08:27, Viresh Kumar wrote:
> Good work Lee, looks mostly okay. Few nits below.

Also, it may make sense to quit early of opp-v2 isn't present in your
/cpus/cpuX node. As we wouldn't be using any of this then.

-- 
viresh
