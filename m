From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Mon, 13 Jan 2014 16:20:30 -0800 (PST)
Subject: [PATCH 3/4] thermal: rcar: Add missing clock handling
In-Reply-To: <CAMuHMdWVZhWKDS46GWo83z940B9+Z-yt1WrBKSuiS+zwYMqZQA@mail.gmail.com>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
 <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
 <87ha9fxoua.wl%kuninori.morimoto.gx@gmail.com>
 <CAMuHMdW+1yP2PqvLTc0tjyrnhGssvn_iK8mCO6u-++pjGYR9KQ@mail.gmail.com>
 <CAMuHMdWVZhWKDS46GWo83z940B9+Z-yt1WrBKSuiS+zwYMqZQA@mail.gmail.com>
Message-ID: <87d2jvh0s5.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Geert

> >> And this patch seems strange for me.
> >> pm_runtime_xxx() is doing same things.
> >> If it didn't work, wrong place is not driver, clock side ?
(snipO
> You were right. After applying both of "ARM: shmobile: compile drivers/sh
> for CONFIG_ARCH_SHMOBILE_MULTI" and "power: clock_ops.c: fixup clk
> prepare/unprepare count" from Ben Dooks the issue went away.

Nice !
Thank you for your help :)

Best regards
---
Kuninori Morimoto
