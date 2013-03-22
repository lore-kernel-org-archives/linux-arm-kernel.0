From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Mar 2013 14:21:28 +0100
Subject: [PATCH 0/9] More ux500 multiplatform stuff
In-Reply-To: <1363902674-6456-1-git-send-email-arnd@arndb.de>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363902674-6456-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdbaRyHxeJM=JT+9CtVf-_u90wCzjePDvsNq-EQd_NxLdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 10:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Your patches from this morning made me curious about how much is still
> missing to actually enable multiplatform support on ux500.

On the surface of it, not that much as you see :-D

> This is
> what I came up with, on top of your patches. Feel free to take what
> you need if you don't already have the same patches.
>
> I've successfully built "allmodconfig" with all the other v6/v7
> platforms enabled as well.

Unfortunately the platform stops booting after
2/9 "ARM: ux500: split out prcmu initialization"
so I will look closer at this.

This patch:
"ARM: ux500: kill mach/hardware.h some more"
I will squash into the actual removal patch, it's just
some sloppy work by me :-/

I will try to move some of the patches to the
front of the series so we only have the tricky stuff to
fix.

And there are some non-bisectable patches due to the
driver in staging (which was put there because Synaptics would
submit another driver "real soon now" and that was something like
two years ago), so I might have to squash some of them together to one.

Thanks!
Linus Walleij
