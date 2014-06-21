From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 22:14:04 -0400
Subject: [PATCH v2] irqchip: nvic: Use the generic noop function
In-Reply-To: <1401894112-13386-1-git-send-email-daniel.thompson@linaro.org>
References: <1401885425-12378-1-git-send-email-daniel.thompson@linaro.org>
 <1401894112-13386-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140621021404.GD21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 04:01:52PM +0100, Daniel Thompson wrote:
> Using the generic function saves looking up this custom one in a source
> navigator.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> ---
>  drivers/irqchip/irq-nvic.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Applied to irqchip/core with Uwe's Ack.

thx,

Jason.
