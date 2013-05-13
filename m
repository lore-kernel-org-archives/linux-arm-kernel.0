From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 11:19:34 -0400
Subject: [PATCH 09/14] ARM: mvebu: Remove init_irq declaration in
 machine description
In-Reply-To: <1368438253-28218-10-git-send-email-maxime.ripard@free-electrons.com>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368438253-28218-10-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130513151934.GM31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 11:44:08AM +0200, Maxime Ripard wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for mvebu as well.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/armada-370-xp.c | 1 -
>  1 file changed, 1 deletion(-)

Maxime,

Do do want the individual submaintainers to take these?  Or, send one
branch to Arnd and Olof?  I'm fine with either one as any merge
conflicts should be trivial.

In either case,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
