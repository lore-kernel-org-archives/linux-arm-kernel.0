From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 31 Jul 2013 17:55:05 -0700 (PDT)
Subject: [PATCH 00/13] ARM: shmobile: Rework ->init_time() /
 shmobile_timer_init()
In-Reply-To: <20130731190110.31796.96552.sendpatchset@w520>
References: <20130731190110.31796.96552.sendpatchset@w520>
Message-ID: <87hafa2psq.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> [PATCH 01/13] ARM: shmobile: Use default ->init_time() on r8a73a4
> [PATCH 02/13] ARM: shmobile: Use default ->init_time() on r8a7740
> [PATCH 03/13] ARM: shmobile: Use default ->init_time() on r8a7778
> [PATCH 04/13] ARM: shmobile: Use default ->init_time() on r8a7779
> [PATCH 05/13] ARM: shmobile: Use default ->init_time() on Bockw
> [PATCH 06/13] ARM: shmobile: Use default ->init_time() on Bockw DT ref
> [PATCH 07/13] ARM: shmobile: Use default ->init_time() on Armadillo DT ref
> [PATCH 08/13] ARM: shmobile: Use default ->init_time() on APE6EVM
> [PATCH 09/13] ARM: shmobile: Use default ->init_time() on APE6EVM DT ref
> [PATCH 10/13] ARM: shmobile: Use default ->init_time() on Marzen DT ref
> [PATCH 11/13] ARM: shmobile: Use default ->init_time() on KZM9G DT ref
> [PATCH 12/13] ARM: shmobile: Use clocksource_of_init() on r8a7790
> [PATCH 13/13] ARM: shmobile: Remove unused shmobile_init_time()

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
