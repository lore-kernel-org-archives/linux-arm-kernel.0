From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 12 Apr 2016 16:04:11 +0800
Subject: [PATCH] ARM: imx: always use TWD on IMX6Q
In-Reply-To: <1459957147-10133-1-git-send-email-bigeasy@linutronix.de>
References: <1459957147-10133-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <20160412080410.GE23438@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 05:39:07PM +0200, Sebastian Andrzej Siewior wrote:
> There is no reason to limit the TWD to be used on SMP kernels only if the
> hardware has it available.
> On Wandboard i.MX6SOLO, running PREEMPT-RT and cyclictest I see as max
> immediately after start in idle:
> UP : ~90us
> SMP: ~50us
> UP + TWD: ~20us.
> Based on this numbers I prefer the TWD over the slightly slower MXC
> timer.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied, thanks.
