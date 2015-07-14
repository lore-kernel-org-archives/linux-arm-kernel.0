From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 14 Jul 2015 11:10:58 +0200 (CEST)
Subject: [patch] ARM64/irq: Use access helper irq_data_get_affinity_mask()
In-Reply-To: <20150714090709.GB13555@e104818-lin.cambridge.arm.com>
References: <20150713100010.928355574@linutronix.de>
 <20150714090709.GB13555@e104818-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.11.1507141110400.20072@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Jul 2015, Catalin Marinas wrote:
> Hi Thomas,
> 
> On Mon, Jul 13, 2015 at 08:30:04PM -0000, Thomas Gleixner wrote:
> > From: Jiang Liu <jiang.liu@linux.intel.com>
> > 
> > This is a preparatory patch for moving irq_data struct members.
> > 
> > Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> > Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> What's the plan with this patch? Do you get it via your tree together
> with other patches or we should merge it via the arm64 tree? If the

Just push it through arm64, please.

Thanks,

	tglx
