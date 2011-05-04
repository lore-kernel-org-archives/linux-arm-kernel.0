From: mingo@elte.hu (Ingo Molnar)
Date: Wed, 4 May 2011 09:03:12 +0200
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Message-ID: <20110504070312.GD20828@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Sven Eckelmann <sven@narfation.org> wrote:

> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.

>  arch/x86/include/asm/atomic.h      |    1 +
>  arch/x86/include/asm/atomic64_64.h |    1 +

Acked-by: Ingo Molnar <mingo@elte.hu>

Thanks,

	Ingo
