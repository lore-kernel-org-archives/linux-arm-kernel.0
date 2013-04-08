From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 07 Apr 2013 18:07:16 -0700 (PDT)
Subject: [RFC/PATCH 0/7] ARCH: shmobile: defconfig consolidation
In-Reply-To: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
References: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <87sj31omnz.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> Simon Horman (7):
>  ARM: shmobile: prune defconfig
>  ARM: shmobile: make defconfig canonical
>  ARM: shmobile: Add kzm9d to consolidated defconfig
>  ARM: shmobile: Add mackerel to consolidated defconfig
>  ARM: shmobile: defconfig: Remove armadillo800eva defconfig
>  ARM: shmobile: defconfig: Remove kzm9d defconfig
>  ARM: shmobile: defconfig: Remove mackerel defconfig
(snip)
> Morimoto-san, I suspect it may be possible to add support for the
> bockw board to the consolidated defconfig if its boot loader supports
> booting using a zImage. In this case even though the base memory address
> is not the same as the boards above it should be possible to specify
> the base address from the boot loader. As I do not have a bockw board
> I am wondering if you could investigate this.

I tested shmobile_defconfig on Bock-W board.
It works with...

 1) I added R8A7778 SoC on .config
 2) I added Bock-W on .config
 3) I fixuped CONFIG_MEMORY_START, CONFIG_MEMORY_SIZE value on .config

It is correct method ?

Best regards
---
Kuninori Morimoto
