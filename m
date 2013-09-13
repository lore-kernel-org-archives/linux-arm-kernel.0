From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Fri, 13 Sep 2013 17:27:58 +0200
Subject: [PATCH 097/228] cpufreq: cris: don't initialize part of policy
 that is set by core too
In-Reply-To: <ba2db8dd7d87b0a284be900bf908c09444e6d979.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <ba2db8dd7d87b0a284be900bf908c09444e6d979.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <20130913152758.GK32443@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 03:00:43PM +0200, Viresh Kumar wrote:
> Many common initializations of struct policy are moved to core now and hence
> this driver doesn't need to do it. This patch removes such code.
> 
> Most recent of those changes is to call ->get() in the core after calling
> ->init().

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Cc: Mikael Starvik <starvik@axis.com>
> Cc: linux-cris-kernel at axis.com
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
