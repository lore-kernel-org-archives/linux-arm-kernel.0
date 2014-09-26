From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 26 Sep 2014 13:03:26 -0700
Subject: [PATCH] sched/nohz: add debugfs control over
 sched_tick_max_deferment
In-Reply-To: <1411760732-14102-1-git-send-email-khilman@kernel.org>
References: <1411760732-14102-1-git-send-email-khilman@kernel.org>
Message-ID: <CAMAWPa-WMkb_rJZ_XBCd3+pTtu5-SwN7F-0pNs3SrsokDDH5sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frederic,

On Fri, Sep 26, 2014 at 12:45 PM, Kevin Hilman <khilman@kernel.org> wrote:
> From: Kevin Hilman <khilman@linaro.org>
>
> Allow debugfs override of sched_tick_max_deferment in order to ease
> finding/fixing the remaining issues with full nohz.
>
> The value to be written is in jiffies, and -1 means the max deferment
> is disabled (scheduler_tick_max_deferment() returns KTIME_MAX.)
>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

This is just an attempt to revive and hopefully finalize the
discussion started a while back[1].

Kevin

[1] https://lkml.org/lkml/2014/1/14/914
