From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 05 Jun 2013 00:29:31 -0700 (PDT)
Subject: [PATCH 00/15] ARM: shmobile: uImage load address rework
In-Reply-To: <20130605070616.13311.69049.sendpatchset@w520>
References: <20130605070616.13311.69049.sendpatchset@w520>
Message-ID: <87a9n5582w.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> ARM: shmobile: uImage load address rework
> 
> [PATCH 01/15] ARM: shmobile: Per-board uImage load addresses
> [PATCH 02/15] ARM: shmobile: AG5EVM uImage rework
> [PATCH 03/15] ARM: shmobile: AP4EVB uImage rework
> [PATCH 04/15] ARM: shmobile: APE6EVM uImage rework
> [PATCH 05/15] ARM: shmobile: Armadillo800EVA uImage rework
> [PATCH 06/15] ARM: shmobile: Bock-W uImage rework
> [PATCH 07/15] ARM: shmobile: Bonito uImage rework
> [PATCH 08/15] ARM: shmobile: KZM9D uImage rework
> [PATCH 09/15] ARM: shmobile: KZM9G uImage rework
> [PATCH 10/15] ARM: shmobile: Kota2 uImage rework
> [PATCH 11/15] ARM: shmobile: Lager uImage rework
> [PATCH 12/15] ARM: shmobile: Mackerel uImage rework
> [PATCH 13/15] ARM: shmobile: Marzen uImage rework
> [PATCH 14/15] ARM: shmobile: Armadillo800EVA reference uImage rework
> [PATCH 15/15] ARM: shmobile: Remove MEMORY_START uImage load address

I tested these patches on Bock-W board (as 0x60008000 binary),
and on Mackerel board (as 0x40008000 binary)
These work well for me :)

I have same opinion with Laurent.
5) and 14) can be 1 patch if you need to sent v2 patches :P

for 6), 12) patch

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

for all patches

Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
