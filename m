From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Jan 2013 15:40:01 +0100
Subject: [GIT PULL] ux500 <mach/id.h> removal
In-Reply-To: <201301302315.22357.arnd@arndb.de>
References: <CACRpkdY9BDyGQ-DiEhTiyHEYoxpGiL+H0baqsBYX_a-0upktUQ@mail.gmail.com>
 <CAOesGMiKCHUz9BJ31o-4kthr0CZABuL7SuuMNEjbkUQ06KsfMw@mail.gmail.com>
 <CACRpkdYmTTgpnAOoNM3RJiF_oADgbuGK-vw6JF8J9rPAttA5PQ@mail.gmail.com>
 <201301302315.22357.arnd@arndb.de>
Message-ID: <CACRpkdYo9AU2Wic7UNG_CemyO5NFrgFdz1UNC8ciOE8T0joZbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> Unrelated to this: The mach/id.h removal seems to have caused a few
> build errors in the for-next tree with u8500_defconfig. Can you have
> a look at what went wrong there?

Yes ... hm.

I have no clue how this happened, somehow new dependencues
have appeared and I've somehow had a config that builds without
some of the drivers or something :-(

Or I built the wrong branch and thought it was clear to go.

Shall we just drop it until I've fixed it up?

Yours,
Linus Walleij
