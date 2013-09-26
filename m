From: olof@lixom.net (Olof Johansson)
Date: Wed, 25 Sep 2013 21:11:56 -0700
Subject: [GIT PULL] at91: fixes for 3.12 #1
In-Reply-To: <1380027682-8132-1-git-send-email-nicolas.ferre@atmel.com>
References: <1380027682-8132-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <CAOesGMjDXFJy3FRRUuFH2EXdwcELYAweqckZfTLrOqEvDoefAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 6:01 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Arnd, Olof, Kevin,
>
> This is the first batch of fixes for AT91.
> I think that the removal of the void flag IRQF_DISABLED can be schedulled in
> this timeframe as we are pretty early in the cycle and that this patch
> shouldn't wait more.

Those patches have been trickling in, and I'm not sure if all
maintainers are picking them up for 3.12.

Anyway, it's still fairly early and it's a tiny patch.

>
> Thanks, best regards,
>
> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
>
>   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
>
> are available in the git repository at:
>
>   git://github.com/at91linux/linux-at91.git tags/at91-fixes

Pulled, thanks.

-Olof
