From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Mar 2014 11:27:17 +0100
Subject: [PATCH 44/62] ARM: integrator: refine CPU selection
In-Reply-To: <4776688.CZBeEWFJox@wuerfel>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <201403201148.16239.arnd@arndb.de>
 <CACRpkdYPvoobHqG4oQaJbrXDZQwYP6H9n7MSuXDt3MonNsC5jw@mail.gmail.com>
 <4776688.CZBeEWFJox@wuerfel>
Message-ID: <CACRpkdZt_ngaYQgBnd21NWiGVk_PFOFyc5fykQk9axB5cs7p=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 12:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> My point is that once the two are multiplatform, we wouldn't
> do the CPU selection patches like this anymore. Instead, I would just do
>
> config CPU_ARM920T
>         bool "Support ARM920T processor" if ARCH_MULTI_V4T
>         ...
>
> config CPU_ARM926T
>         bool "Support ARM920T processor" if ARCH_MULTI_V5
>         ...

Ah I see, that's elegant. Yes let's go for this.

Yours,
Linus Walleij
