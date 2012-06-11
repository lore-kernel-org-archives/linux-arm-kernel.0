From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 23:42:24 +0200
Subject: [PATCH 13/14] ARM: ux500: Enable the AB8500 RTC for all DT:ed
 DB8500 based devices
In-Reply-To: <1339428307-3850-14-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-14-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdb56UA0-uxKFYQ+fZmJf9Y26NwWLdKc5x-ZBfqUK0cTFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 5:25 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we add a node for the AB8500 Real Time Clock in all devices
> supporting the DB8500. The AB8500 RTC driver makes use of named
> interrupts we provide support for this too.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
