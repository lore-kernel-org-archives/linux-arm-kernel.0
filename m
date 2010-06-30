From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 30 Jun 2010 23:58:42 +0200
Subject: [PATCH 0/2] RealView barriers and ARM_DMA_MEM_BUFFERABLE
In-Reply-To: <20100630104105.16712.66741.stgit@e102109-lin.cambridge.arm.com>
References: <20100630104105.16712.66741.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTikBTz8qqohhcfhSWW9cO384pientK2tXPtKuYVv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/30 Catalin Marinas <catalin.marinas@arm.com>:

> Linus, could you please confirm that the second patch still fixes the
> PB1176 issues for you?

It does, the system comes up, prints:
L2x0 series cache controller enabled
l2x0: 8 ways, CACHE_ID 0x41000486, AUX_CTRL 0x02730fff

No hangs whatsoever.
Tested-by: Linus Walleij <linus.walleij@stericsson.com>

Please queue this up for the -rc series...

Yours,
Linus Walleij
