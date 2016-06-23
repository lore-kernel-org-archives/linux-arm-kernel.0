From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 23 Jun 2016 18:53:37 +0000
Subject: [[PATCH v2] 08/11] irqchip: exynos: fix usage of __raw IO
In-Reply-To: <1466504432-24187-9-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466504432-24187-9-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160623185337.GJ9922@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben,

On Tue, Jun 21, 2016 at 11:20:29AM +0100, Ben Dooks wrote:
> Fix the use of __raw IO accesors when the readl/writel_relaxed
> are better. This should fix issues if the kernel is running as
> big endian.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Jason Cooper <jason@lakedaemon.net>
> CC: Marc Zyngier <marc.zyngier@arm.com>w
> ---
>  drivers/irqchip/exynos-combiner.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied patches 8 and 9 of this series to irqchip/misc with minor
subject line reformatting (watch double square brackets).

thx,

Jason.
