From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 17 Jun 2011 17:10:36 +0200
Subject: [PATCH] plat-iop: fix build error
In-Reply-To: <1308312232-30488-1-git-send-email-linus.walleij@stericsson.com>
	(Linus Walleij's message of "Fri, 17 Jun 2011 14:03:52 +0200")
References: <1308312232-30488-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <87ei2sfq8j.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@stericsson.com> writes:

Hi,

> From: Linus Walleij <linus.walleij@linaro.org>
>
> The iop13xx_defconfig didn't build since the platform code uses
> defines from <asm/ptrace.h>. Simply add the include so it
> compiles.

fwiw, same patch has been sent some time ago
(http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052021.html)
but I don't know if it has been merged.

Arnaud
