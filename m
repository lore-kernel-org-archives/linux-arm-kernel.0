From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 6 Sep 2012 13:02:45 +0530
Subject: [PATCH] cpufreq: OMAP: remove redundant loops_per_jiffy code
In-Reply-To: <1346915424-25868-1-git-send-email-shawn.guo@linaro.org>
References: <1346915424-25868-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAMQu2gwcBNNAPs12GqZb6rteW3AzcAxQEv51YJb+rPjuCv-QEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Thu, Sep 6, 2012 at 12:40 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> With ARM smp common code updating loops_per_jiffy in a cpufreq
> transiton notifier call, the loops_per_jiffy code in omap-cpufreq
> driver becomes redundant.  Remove it.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
I have acked this patch when Richard Zhao posted
it earlier [1]. Seems to be the same patch so ack applies
here as well.

Regards
Santosh

[1] http://www.spinics.net/lists/cpufreq/msg02992.html
