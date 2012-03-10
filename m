From: olof@lixom.net (Olof Johansson)
Date: Sat, 10 Mar 2012 08:30:18 -0800
Subject: [GIT PULL] DaVinci DM644x video display support
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6317EEB34@DBDE01.ent.ti.com>
References: <DF0F476B391FA8409C78302C7BA518B6317EEB34@DBDE01.ent.ti.com>
Message-ID: <CAOesGMhcowDuD9FDUG8cMy-a7s-43Ch-=WWjNvrmCtS6+3=t6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 8, 2012 at 11:23 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> Hi Arnd, Olof,
>
> Can you please pull these two patches adding support
> for DaVinci DM644x V4L2 display support for v3.4.
>
> These patches heavily depend on the clean-up series sent earlier.
> Since the clean-up series is already included in for-next branch
> of arm-soc, I have generated a request using that as baseline.
>
> Let me know if that's not desirable, and I can do it any
> other way you want.
>
> Thanks,
> Sekhar
>
> The following changes since commit 3a034af7c1a3c55014eeb15a9c9430e9f72810e4:
> ?Arnd Bergmann (1):
> ? ? ? ?Merge branch 'next/fixes-non-critical' into for-next

It looks like this branch is based on the contents of the for-next
branch. That's not a stable base so I can't pull it.

If you need it to build on contents already in arm-soc, you need to
base it on either your own cleanup branch, or the aggregate next/*
branch in arm-soc. for-next is rebuilt, and is never sent up to Linus
in it's current form.

Since you said they require the cleanup branch as a base, please
rebase them on top of next/cleanup instead.

Thanks!


-Olof
