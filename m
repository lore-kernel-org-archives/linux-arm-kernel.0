From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Jun 2016 20:35:12 +0800
Subject: [PATCH] ARM: imx6: fix missing <soc/imx/cpuidle.h> in
 cpuidle-imx6q.c
In-Reply-To: <1466511191-31967-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466511191-31967-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160621123512.GI21364@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 01:13:11PM +0100, Ben Dooks wrote:
> The <soc/imx/cpuidle.h> file has declarations of two funcitons
> exported from cpuidle-imx6q.c but it is not included. Fix the
> following warnings by adding the include:
> 
> arch/arm/mach-imx/cpuidle-imx6q.c:71:6: warning: symbol 'imx6q_cpuidle_fec_irqs_used' was not declared. Should it be static?
> arch/arm/mach-imx/cpuidle-imx6q.c:76:6: warning: symbol 'imx6q_cpuidle_fec_irqs_unused' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied, thanks.
