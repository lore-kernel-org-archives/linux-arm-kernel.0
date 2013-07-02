From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 2 Jul 2013 09:36:46 -0400
Subject: [PATCH v5 5/7] ARM: kirkwood: convert to DT irqchip and
 clocksource
In-Reply-To: <1372770907-32738-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1372763023-12374-6-git-send-email-sebastian.hesselbarth@gmail.com>
 <1372770907-32738-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130702133646.GB17110@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 03:15:07PM +0200, Sebastian Hesselbarth wrote:
> With recent support for true irqchip and clocksource drivers for Orion
> SoCs, now make use of it on DT enabled Kirkwood boards.
> 
> This also introduces a new Kconfig option for legacy (non-DT) Kirkwood
> where old code is moved out to and polishes DT board file a little bit.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> --- 
> Changelog:
> v4->v5:
> - do not re-introduce already removed init_dma_coherent_pool_size
>   (Reported by Jason Cooper)
> 
> @Jason: I did a 'git grep init_dma_coherent_pool_size' and now there
> are no users of that function - as it was before. Patch 6/7 only differs
> in the 'index' diff line because of the rebase here. I will not resend that,
> it should still apply.

ok, great, thanks for turning that around.

thx,

Jason.
