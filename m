From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 07 Apr 2013 19:35:53 -0700 (PDT)
Subject: [PATCH 00/02] ARM: shmobile: r8a7790 Lager arch timer fixes
In-Reply-To: <20130408020637.GF13103@verge.net.au>
References: <20130408012318.13555.58237.sendpatchset@w520>
 <87r4ilolmh.wl%kuninori.morimoto.gx@renesas.com>
 <20130408020637.GF13103@verge.net.au>
Message-ID: <87ppy5oika.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> > I guess shmobile_timer_init() will be conflict (or compile error)
> > on next (?) merge window thought...
> > but, for current code/branch
> 
> I guess that the solution is to ensure that patch 1 is applied
> before patch 2. Am I missing something?

Sorry for my confusion
I meant shmobile_timer_init() will be removed from ARM SoC side.
But I'm not sure for detail

Best regards
---
Kuninori Morimoto
