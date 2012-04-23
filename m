From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 23 Apr 2012 11:35:00 +0200
Subject: [PATCH] net/at91_ether: use gpio_to_irq for phy IRQ line
In-Reply-To: <1335173852-582-1-git-send-email-nicolas.ferre@atmel.com>
References: <1335173852-582-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20120423093500.GG9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:37 Mon 23 Apr     , Nicolas Ferre wrote:
> Use the gpio_to_irq() function to retrieve the phy IRQ line
> from the GPIO pin specification.
> This fix is needed now that we have moved to irqdomains on AT91.
> 
> Reported-by: Jamie Iles <jamie@jamieiles.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Andrew Victor <avictor.za@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: netdev at vger.kernel.org
> ---
>  drivers/net/ethernet/cadence/at91_ether.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
I send a send a patch to cleanup the at91_ether please rebase over it

this patch is here  for a while

Best Regards,
J.
