From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 20 Oct 2010 09:00:01 +0200
Subject: [RFC, PATCH 0/5] unify definition of CLOCK_TICK_RATE across
	different platforms
In-Reply-To: <20101020045110.GW12979@mail.wantstofly.org>
References: <20101020045110.GW12979@mail.wantstofly.org>
Message-ID: <AANLkTi=+rgRiDGTWR7CKrTJXs3FGF+5AMwWVPOwU_vHL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/20 Lennert Buytenhek <buytenh@wantstofly.org>:

> One of the things preventing building an ARM multiplatform kernel
> image is the fact that CLOCK_TICK_RATE (and as a consequence, LATCH)
> is defined differently for each ARM platform.

That thing has really annoyed me for some time, so thanks!
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

For all patches touching U300, Ux500.

Yours,
Linus Walleij
