From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Aug 2011 10:32:04 +0100
Subject: [PATCHv4 2/2] ARM: P2V: Remove ARM_PATCH_PHYS_VIRT_16BIT
In-Reply-To: <1311794355-26988-2-git-send-email-sboyd@codeaurora.org>
References: <1311794355-26988-1-git-send-email-sboyd@codeaurora.org>
	<1311794355-26988-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20110811093204.GE4775@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2011 at 12:19:15PM -0700, Stephen Boyd wrote:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> This code can be removed now that MSM targets no longer need the 16-bit
> offsets for P2V.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Can you submit these two patches to the patch system so they can be
integrated with the patch to enable by default the p2v patching please?

You will need to update then against my for-next branch to account for
that change - it should only be context changes in arch/arm/Kconfig.

Thanks.
