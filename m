From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 19 May 2013 16:17:23 -0400
Subject: [PATCH 15/20] ARM: mvebu: Remove init_irq declaration in
 machine description
In-Reply-To: <1368545933-7430-16-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-16-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130519201723.GK11137@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 05:38:48PM +0200, Maxime Ripard wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for mvebu as well.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/mach-mvebu/armada-370-xp.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to mvebu/cleanup

thx,

Jason.
