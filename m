From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Fri, 13 Sep 2013 16:11:23 +0200
Subject: [PATCH 017/228] cpufreq: cris: use
 cpufreq_table_validate_and_show()
In-Reply-To: <004c82aa4bdb721a03b38b3b5ef5fe7ca7841773.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <004c82aa4bdb721a03b38b3b5ef5fe7ca7841773.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <20130913141122.GD32443@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 02:59:23PM +0200, Viresh Kumar wrote:
> Lets use cpufreq_table_validate_and_show() instead of calling
> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Cc: Mikael Starvik <starvik@axis.com>
> Cc: linux-cris-kernel at axis.com
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
