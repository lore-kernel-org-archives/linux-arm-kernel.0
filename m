From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2012 14:39:37 -0800
Subject: [GIT PULL] DaVinci fixes for v3.3-rc
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6317A70FB@DBDE01.ent.ti.com>
References: <DF0F476B391FA8409C78302C7BA518B6317A70FB@DBDE01.ent.ti.com>
Message-ID: <CAOesGMgkkO1B7fk6gDYvh+N32rtzJuPB34Hyz=nQ2OimXU1azw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 27, 2012 at 9:26 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> Hi Olof, Arnd,
>
> Can you please pull these DaVinci fixes for the next v3.3-rc?
> Both the patches have not been stable tagged. The fix by me
> is a v3.3 regression. The fix by Bas van den Berg is not critical
> enough to get into stable kernels.
>
> Thanks,
> Sekhar
>
> The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
> ?Linus Torvalds (1):
> ? ? ? ?Linux 3.3-rc1
>
> are available in the git repository at:
>
> ?git://gitorious.org/linux-davinci/linux-davinci.git fixes
>
> Bas van den Berg (1):
> ? ? ?ARM: davinci: DA850: remove non-existing pll1_sysclk4-7 clocks
>
> Sekhar Nori (1):
> ? ? ?ARM: davinci: update mdio bus name

Looks like the clock removal is almost crossing over into cleanup
territory not a fix. In the future please help us out by briefly
motivate why it's a fix (for something that is broken) and not a
cleanup if it's not obvious from reading it -- noncritical fixes are
usually saved for the next merge window instead.

With that said; I've pulled the branch.


Thanks!

-Olof
