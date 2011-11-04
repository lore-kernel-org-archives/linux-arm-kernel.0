From: shawn.gsc@gmail.com (Shawn Guo)
Date: Sat, 5 Nov 2011 05:15:40 +0800
Subject: [PATCH v3 04/17] ARM: mxc: convert smp platforms to global
	gic_handle_irq()
In-Reply-To: <1320425871-30564-5-git-send-email-marc.zyngier@arm.com>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
	<1320425871-30564-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20111104211540.GB3546@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 04:57:38PM +0000, Marc Zyngier wrote:
> Convert the SMP shmobile platforms to use the global gic_handle_irq()

s/shmobile/imx

Other than the typo there, for patches #2 and #4:

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> function instead a private function.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
