From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 17 Jan 2013 22:28:46 -0800 (PST)
Subject: [PATCH] ARM: shmobile: armadillo800eva: set clock rates before
 timer init
In-Reply-To: <1358485325-19673-1-git-send-email-hdk@igel.co.jp>
References: <1358485325-19673-1-git-send-email-hdk@igel.co.jp>
Message-ID: <87r4lj9f8l.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Previously clock rates were set after initialization of timer.
> Therefore the timer used the default extal1 clock rate (25MHz)
> instead of the correct rate for this board (24MHz).
> 
> Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>
> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
