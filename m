From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Fri, 13 Sep 2013 17:24:43 +0200
Subject: [PATCH 153/228] cpufreq: cris: Convert to light weight
 ->target_index() routine
In-Reply-To: <73fe150773b41450f222c179e4a7ea84884a119e.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <73fe150773b41450f222c179e4a7ea84884a119e.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <20130913152443.GH32443@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 03:01:39PM +0200, Viresh Kumar wrote:
> This patch converts existing .target() to newly defined light weight
> .target_index() routine for this driver.
> 
> CPUFreq core will call cpufreq_frequency_table_target() before calling this
> routine and will pass index to it.

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Cc: Mikael Starvik <starvik@axis.com>
> Cc: linux-cris-kernel at axis.com
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
