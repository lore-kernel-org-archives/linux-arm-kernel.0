From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 23 Jan 2016 23:15:17 +0100
Subject: [PATCH] pinctrl: pxa: export pxa2xx_pinctrl_init()
In-Reply-To: <1453577113-14423-1-git-send-email-yamada.masahiro@socionext.com>
 (Masahiro Yamada's message of "Sun, 24 Jan 2016 04:25:13 +0900")
References: <1453577113-14423-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <87fuxoaqoa.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Building pinctrl-pxa27x.c as a module causes a link error:
>
> ERROR: "pxa2xx_pinctrl_init" [drivers/pinctrl/pxa/pinctrl-pxa27x.ko] undefined!
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Yeah, I see no other way out to spare namespace polution.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
