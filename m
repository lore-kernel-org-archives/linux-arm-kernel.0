From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 17 Aug 2014 13:04:53 -0400
Subject: [PATCH] irq: gic-v3: Tag all low level accessors __maybey_unused
In-Reply-To: <1406748194-21094-1-git-send-email-broonie@kernel.org>
References: <1406748194-21094-1-git-send-email-broonie@kernel.org>
Message-ID: <20140817170453.GE12769@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Wed, Jul 30, 2014 at 08:23:14PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> This is only really needed for gic_write_sgi1r in the !SMP case since it
> is only referenced in the SMP initialisation code but it seems better to
> have these functions all next to each other and declared consistently.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied to irqchip/urgent

thx,

Jason.
