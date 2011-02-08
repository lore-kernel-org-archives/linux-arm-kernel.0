From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 08 Feb 2011 16:50:42 +0300
Subject: [PATCH 6/9] plat-nomadik: type secondary IRQ correctly
In-Reply-To: <1297156854-32295-7-git-send-email-linus.walleij@stericsson.com>
References: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
	<1297156854-32295-7-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4D514A32.7070202@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08-02-2011 12:20, Linus Walleij wrote:

> From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>

> Coverity found that we were checking an unsigned variable for
> greater than zero. Type it correctly.

    There's nothing criminal in checking unsigned for > 0. Perhaps you meant >= 0?

> Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

    Twice?

WBR, Sergei
