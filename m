From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 14 Jun 2013 14:37:42 -0400
Subject: [PATCH 5/7] arm: orion: use irq_get_trigger_type() to get IRQ
 flags
In-Reply-To: <1371228049-27080-6-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
 <1371228049-27080-6-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20130614183742.GJ31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 06:40:47PM +0200, Javier Martinez Canillas wrote:
> Use irq_get_trigger_type() to get the IRQ trigger type flags
> instead calling irqd_get_trigger_type(irq_get_irq_data(irq))
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/plat-orion/gpio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
