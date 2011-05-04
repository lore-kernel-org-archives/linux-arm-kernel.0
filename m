From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 4 May 2011 14:17:51 +0200
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Message-ID: <BANLkTi=kRLxKS417xhaWDpF4h8+VTcUQQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2011 at 23:30, Sven Eckelmann <sven@narfation.org> wrote:
> Introduce an *_dec_not_zero operation. ?Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.

> ?arch/m68k/include/asm/atomic.h ? ? | ? ?1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

? ? ? ? ? ? ? ? ? ? ? ? Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
? ? ? ? ? ? ? ? ? ? ? ? ? ?? ?? -- Linus Torvalds
