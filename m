From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Feb 2013 14:22:47 -0800
Subject: [GIT PULL] ux500 <mach/id.h> removal
In-Reply-To: <CACRpkdYo9AU2Wic7UNG_CemyO5NFrgFdz1UNC8ciOE8T0joZbA@mail.gmail.com>
References: <CACRpkdY9BDyGQ-DiEhTiyHEYoxpGiL+H0baqsBYX_a-0upktUQ@mail.gmail.com>
 <CAOesGMiKCHUz9BJ31o-4kthr0CZABuL7SuuMNEjbkUQ06KsfMw@mail.gmail.com>
 <CACRpkdYmTTgpnAOoNM3RJiF_oADgbuGK-vw6JF8J9rPAttA5PQ@mail.gmail.com>
 <201301302315.22357.arnd@arndb.de>
 <CACRpkdYo9AU2Wic7UNG_CemyO5NFrgFdz1UNC8ciOE8T0joZbA@mail.gmail.com>
Message-ID: <CAOesGMhEJi-kW8GwCM7W7bWYqWa_6=im=79GKLoXHdw5zi9pzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 31, 2013 at 6:40 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jan 31, 2013 at 12:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> Unrelated to this: The mach/id.h removal seems to have caused a few
>> build errors in the for-next tree with u8500_defconfig. Can you have
>> a look at what went wrong there?
>
> Yes ... hm.
>
> I have no clue how this happened, somehow new dependencues
> have appeared and I've somehow had a config that builds without
> some of the drivers or something :-(
>
> Or I built the wrong branch and thought it was clear to go.
>
> Shall we just drop it until I've fixed it up?

What's the expected timeline for fixup? I can revert the patch in
for-next and we can take a fix on top of the branch that introduced
the breakage, if that's easier.


-Olof
