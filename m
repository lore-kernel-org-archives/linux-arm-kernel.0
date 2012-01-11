From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 11 Jan 2012 15:21:46 -0800
Subject: [GIT PULL 05/11] SoC-level changes for tegra and omap
In-Reply-To: <CAMuHMdVvQzdxw0B3ZMtJej=9Qwm7Qbd5aenSOfa=QPhX8UUt2w@mail.gmail.com>
References: <1326147171-13752-1-git-send-email-arnd@arndb.de>
 <CA+55aFw15sw0PWtom88vJx1M45CLuvpZABQAxMOQ+xowz8Xq2A@mail.gmail.com>
 <7vty438575.fsf@alter.siamese.dyndns.org> <201201111812.46431.arnd@arndb.de>
 <CAMuHMdVvQzdxw0B3ZMtJej=9Qwm7Qbd5aenSOfa=QPhX8UUt2w@mail.gmail.com>
Message-ID: <CA+55aFxDdCUd_h2Xk3H3giO4GsAE05Y8-uN1tqRNOJiKV-mhGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 12:29 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> And all of this would look nice if you would have done a rebase on top of the
> latest tagged version of Linus' tree that contains all prerequisites, right?

Rebasing means that nobody else can depend on or work with that tree,
so it's a no-no.

Sure, it works if you are the only person touching it, but then you
had better not export it at all, so what's the point?

We have had independent problems in another branch exactly because it
was rebased and people merged it, so bringing up rebasing as a
"solution" is wrong-headed. It just causes *more* problems of other
kinds, even if it may make git request-pull trivial.

                        Linus
