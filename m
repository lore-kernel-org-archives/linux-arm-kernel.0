From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Feb 2011 15:17:34 +0100
Subject: [PATCHv3] amba: support pm ops
In-Reply-To: <1298353261-22193-1-git-send-email-rabin.vincent@stericsson.com>
References: <201102212126.10742.rjw@sisk.pl>
	<1298353261-22193-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <AANLkTinDc-VH3moN7RhLiBvX7FnU7t2+n7ECPqO-8m59@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/22 Rabin Vincent <rabin.vincent@stericsson.com>:
> Support pm_ops in the AMBA bus, required to allow drivers to use runtime pm.
> The implementation of AMBA bus pm ops is based on the platform bus
> implementation.
>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> ---
> v3: add a missing header. don't keep an empty dev_pm_ops struct when it's
> ? ?not used.

FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
