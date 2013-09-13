From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Fri, 13 Sep 2013 16:19:00 +0200
Subject: [PATCH 061/228] cpufreq: cris: Use generic cpufreq routines
In-Reply-To: <d5f36a652c8fed4bb90bb711f520c964131a0d61.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <d5f36a652c8fed4bb90bb711f520c964131a0d61.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <20130913141900.GE32443@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 03:00:07PM +0200, Viresh Kumar wrote:
> Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
> and .attr. So its better if we have generic routines for them which can be used
> by cpufreq drivers then.
> 
> This patch uses these generic routines for this driver.

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Cc: Mikael Starvik <starvik@axis.com>
> Cc: linux-cris-kernel at axis.com
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
