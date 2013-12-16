From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Sun, 15 Dec 2013 20:18:26 -0800 (PST)
Subject: [PATCH] ARM: shmobile: r8a7790 - fix shdi resource sies
In-Reply-To: <20131214002752.GA12173@verge.net.au>
References: <1386869040-20849-1-git-send-email-ben.dooks@codethink.co.uk>
 <871u1hsd44.wl%kuninori.morimoto.gx@gmail.com>
 <CANqRtoT86xdh-c73f-_59sD3E=90yW1wOp5Bobmi4qJywA72uA@mail.gmail.com>
 <52AAE9AF.6010704@codethink.co.uk>
 <20131214002752.GA12173@verge.net.au>
Message-ID: <87bo0h1l9w.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Ben, Magnus, Simon

> Morimoto-san, could you help me to create a topic branch for R-Car Gen2
> SDHI by sending me a list of patches and/or brances in other people's
> trees?

First of all, I need to say sorry to Ben.
The SDHI resource size fix was correct, but only for CH0/CH1.

CH0 0x200
CH1 0x200
CH2 0x100
CH3 0x100

are correct size.
Ben, could you please send v2 patch ?

I will send R-Car H2 Lager SDHI support patch (as RFC) soon.

Best regards
---
Kuninori Morimoto
