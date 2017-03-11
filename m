From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 11 Mar 2017 22:30:11 +0100
Subject: [PATCH v1] Revert "clocksource/drivers/tcb_clksrc: Use 32 bit
 tcb as sched_clock"
In-Reply-To: <20170309165838.7683-1-romain.izard.pro@gmail.com>
References: <20170309165838.7683-1-romain.izard.pro@gmail.com>
Message-ID: <20170311213011.GB1753@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 05:58:38PM +0100, Romain Izard wrote:
> This reverts commit 7b9f1d16e6d1 ("clocksource/drivers/tcb_clksrc: Use
> 32 bit tcb as sched_clock"). In the current state, the kernel warns
> against a late registration of the new sched_clock, the printk clock
> resets after only a few minutes, and it seems that scheduling can be
> affected as well.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---

Applied, thanks.

  -- Daniel
