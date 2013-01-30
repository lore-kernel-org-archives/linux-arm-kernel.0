From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 16:12:38 -0800
Subject: [GIT PULL] ux500 <mach/id.h> removal
In-Reply-To: <CACRpkdY9BDyGQ-DiEhTiyHEYoxpGiL+H0baqsBYX_a-0upktUQ@mail.gmail.com>
References: <CACRpkdY9BDyGQ-DiEhTiyHEYoxpGiL+H0baqsBYX_a-0upktUQ@mail.gmail.com>
Message-ID: <CAOesGMiKCHUz9BJ31o-4kthr0CZABuL7SuuMNEjbkUQ06KsfMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 29, 2013 at 10:06 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> Hi ARM SoC maintainers,
>
> This patch set removes the use of <mach/id.h> from being broadcasted across
> the kernel and blocks any further usage of cpu_is* outside of the machine.
>
> Target is v3.9 cleanups.
>
> It is part of our path toward single zImage.
>
> Please pull it in! Detailed description in the tag, MFD hunk ACKed by
> Samuel Ortiz.
>
> Yours,
> Linus Walleij
>
> The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:
>
>   Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-no-idh

Pulled in.

This has a somewhat annoying (but trivial) conflict against your own
code (the cpufreq driver changes).


-Olof
