From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Oct 2012 12:04:55 +0200
Subject: [PATCH] ARM: integrator_cp: fix build failure
In-Reply-To: <1349631760-21350-1-git-send-email-olof@lixom.net>
References: <1349631760-21350-1-git-send-email-olof@lixom.net>
Message-ID: <CACRpkdb_sTqgc6nYa8RpokEBe+kfe2uT9f3SKJQan8iDgefs0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 7, 2012 at 7:42 PM, Olof Johansson <olof@lixom.net> wrote:

> arch/arm/mach-integrator/integrator_cp.c:272:32: error: 'of_aliases'
> undeclared (first use in this function)
>
> Move the OF-only timer init under #ifdef CONFIG_OF, just like
> integrator_ap has it.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>

My mistake.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Olof!
Linus Walleij
