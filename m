From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Mar 2013 08:03:22 +0000
Subject: [PATCH] ARM: gemini: fix build errors
In-Reply-To: <1362543813-7324-1-git-send-email-linus.walleij@linaro.org>
References: <1362543813-7324-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201303060803.22442.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 March 2013, Linus Walleij wrote:
> The Gemini machine has seen some bitrot, here is a patch to make
> it build again.
> 
> Cc: Roel Kluin <roel.kluin@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC maintainers: please apply this patch directly to the
> fixes.
> 
> I notice that nobody seems to care when Gemini breaks. Shall I
> post a patch deleting this machine? Users raise your hands.

I posted a patch to delete it last time around, and got a couple
of Acks, but in the end didn't submit it a second time for 3.9,
so I did not put it in either.

I'd say we put your patch into 3.9 (or the identical patch that
I sent back then), and remove gemini and fa526 in 3.10 unless
any active users show up.

	Arnd
