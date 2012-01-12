From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 11 Jan 2012 22:41:36 -0800
Subject: [GIT PULL 05/11] SoC-level changes for tegra and omap
In-Reply-To: <CAMuHMdWnoKowa0atP0k5X4vukJTnQSNSh9gibxd1Y2e60qK3RQ@mail.gmail.com>
References: <1326147171-13752-1-git-send-email-arnd@arndb.de>
 <CA+55aFw15sw0PWtom88vJx1M45CLuvpZABQAxMOQ+xowz8Xq2A@mail.gmail.com>
 <7vty438575.fsf@alter.siamese.dyndns.org> <201201111812.46431.arnd@arndb.de>
 <CAMuHMdVvQzdxw0B3ZMtJej=9Qwm7Qbd5aenSOfa=QPhX8UUt2w@mail.gmail.com>
 <CA+55aFxDdCUd_h2Xk3H3giO4GsAE05Y8-uN1tqRNOJiKV-mhGg@mail.gmail.com>
 <CAMuHMdWnoKowa0atP0k5X4vukJTnQSNSh9gibxd1Y2e60qK3RQ@mail.gmail.com>
Message-ID: <CA+55aFxY5JGEGgeR8S8JKR_xC75g8MYOiVvGfisQGxf5oXD+7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 10:32 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> That's why you need two branches:
> ?1. a non-rebasing one for development,
> ?2. a rebasing one containing cherry-picked (possibly folded) commits for
> ? ? preparing for upstream delivery.

Stop being a moron.

Go back and read the "nobody can work with you". If you rebase for
upstream delivery, then that means that everybody that works with you
are workign with a tree that isn't ready for delivery, and that they
cannot rely on.

Just don't do it. If your tree is so ugly that you can't deliver it
upstream, then don't deliver it sideways or downstream either. Keep it
in your own pants, and don't make it public at all. Since nobody can
trust it anyway, and since it isn't the final end result, why even
bother? They can't rely on it, they can't work with it.

So here's the *real* solution:

 - make sure your development tree is in good enough shape that you
can make it public, and can ask me to pull it.

It really is that simple. If you don't think it's in good enough
shape, don't make it public.

                Linus
