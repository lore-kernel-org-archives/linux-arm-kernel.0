From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 Jul 2014 18:32:25 -0700
Subject: [GIT PULL] the great <mach/gpio.h> purge
In-Reply-To: <CACRpkdbPHn6bWdr8t9BrmE2JZZuuVnF7ujzEFdrM86WmrRS5Hw@mail.gmail.com>
References: <CACRpkdbPHn6bWdr8t9BrmE2JZZuuVnF7ujzEFdrM86WmrRS5Hw@mail.gmail.com>
Message-ID: <CAOesGMg2Qn1B7KmaGnZzT0_RiqAbG7hNUg=a=R0CDjxuP6cBBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 1:06 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Hi ARM SoC guys,
>
> please pull in this patch set removing <mach/gpio.h> for good.
> I guess it could collide with some S5P deletion.
> If you decide to pull the S5P purge first, tell me so I can rebase.
>
> Yours,
> Linus Walleij
>
>
> The following changes since commit 4c834452aad01531db949414f94f817a86348d59:
>
>   Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
> tags/gpio-h-purge
>
> for you to fetch changes up to 53430333c345c3531f9443d43c6fba1da693abe4:
>
>   ARM: delete old reference to ARM_GPIOLIB_COMPLEX (2014-06-30 21:37:39 +0200)
>
> ----------------------------------------------------------------
> This is a purge of all things <mach/gpio.h>, now I never
> want to see it again.
>
> - Remove the need for <mach/gpio.h> from S5P
> - Kill CONFIG_NEED_MACH_GPIO_H
> - Kill remnants of ARM_GPIOLIB_COMPLEX

Merged. Fixups were trivial since it was just changes against files
that had been removed.


-Olof
