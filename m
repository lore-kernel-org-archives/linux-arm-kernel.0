From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 28 Mar 2012 12:36:39 -0700
Subject: [GIT PULL 4/5] ARM: More device tree support updates
In-Reply-To: <1332918842-13521-5-git-send-email-olof@lixom.net>
References: <1332918842-13521-1-git-send-email-olof@lixom.net>
 <1332918842-13521-5-git-send-email-olof@lixom.net>
Message-ID: <CA+55aFy4QNiDTL2b37Y870kZ-09sFp9qsFn+SaKCbzWqm8xtoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 12:14 AM, Olof Johansson <olof@lixom.net> wrote:
>
> Merge conflicts and proposed solutions:
>
> arch/arm/mach-ux500/Kconfig: Two new config options. Keep both.

Guys, I'm seeing merge problems that go way beyond this.

Look at that MACH_U8500 config option. It got renamed to MACH_MOP500,
but it continues to live in the tree.

This rename conflict happened earlier and I didn't notice (grep for
it: it's used by a staging driver), so it's already in my pushed out
tree. But it seems to be getting worse, and your proposed merge
solution doesn't cover it.

I'll try to fix things up, but you need to verify my merge. And you
guys should have noticed and noted it, rather than leave it to my
random bumbling about.

                     Linus
