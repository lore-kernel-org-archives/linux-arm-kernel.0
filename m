From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 Jan 2013 10:39:14 +0100
Subject: [GIT PULL] ux500 <mach/id.h> removal
In-Reply-To: <CAOesGMiKCHUz9BJ31o-4kthr0CZABuL7SuuMNEjbkUQ06KsfMw@mail.gmail.com>
References: <CACRpkdY9BDyGQ-DiEhTiyHEYoxpGiL+H0baqsBYX_a-0upktUQ@mail.gmail.com>
 <CAOesGMiKCHUz9BJ31o-4kthr0CZABuL7SuuMNEjbkUQ06KsfMw@mail.gmail.com>
Message-ID: <CACRpkdYmTTgpnAOoNM3RJiF_oADgbuGK-vw6JF8J9rPAttA5PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 1:12 AM, Olof Johansson <olof@lixom.net> wrote:
> [Me]
>>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
>> tags/ux500-no-idh
>
> Pulled in.
>
> This has a somewhat annoying (but trivial) conflict against your own
> code (the cpufreq driver changes).

Arnd always told me to split stuff cleanly on branches, which of course
leads to conflicts like that, but I thought he wanted them, rather than
huge accumulated patch sets built on to of each othere ... a bit hard to
do the right thing here, what would have been the right way?

Does it help if I base stuff off ARM SoC tree branches, and which
ones can be relied upon in that case?

Yours,
Linus Walleij
