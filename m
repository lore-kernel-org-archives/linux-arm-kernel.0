From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2011 21:31:14 +0100
Subject: [PATCHv2 2/2] ARM: ARM_PATCH_PHYS_VIRT_16BIT no longer depends
	on MSM
In-Reply-To: <alpine.LFD.2.00.1107251624560.12766@xanadu.home>
References: <1311614362-9011-1-git-send-email-sboyd@codeaurora.org>
	<1311614362-9011-2-git-send-email-sboyd@codeaurora.org>
	<alpine.LFD.2.00.1107251624560.12766@xanadu.home>
Message-ID: <20110725203114.GF14955@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 04:25:26PM -0400, Nicolas Pitre wrote:
> On Mon, 25 Jul 2011, Stephen Boyd wrote:
> 
> > MSM no longer requires the 16bit version of dynamic P2V. Drop the
> > dependency.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Cc: David Brown <davidb@codeaurora.org>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

As it's now unused, we can kill the additional code which makes things
needlessly more complex...
