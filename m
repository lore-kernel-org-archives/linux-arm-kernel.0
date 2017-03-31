From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Mar 2017 12:02:02 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.12 (#1)
In-Reply-To: <87inmybnbw.fsf@free-electrons.com>
References: <87inmybnbw.fsf@free-electrons.com>
Message-ID: <CAK8P3a2NKheMgyF3OHp+stK7NbnMo21a-qKqPLME436Gk_xbGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 6:23 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
>
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
>
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>
> are available in the git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.12-1
>
> for you to fetch changes up to cd2f0d0d403b7eb779fba04ea9664faa3b625cde:
>
>   ARM: dts: mvebu: linksys: enable buffer manager support (2017-03-23 17:29:42 +0100)
>
> ----------------------------------------------------------------
> mvebu dt for 4.12 (part 1)
>
> - Add node lable for Armada 38x
> - Add support for Synology DS116 NAS and Linksys WRT1900ACS
> - Update mbus controller description on Armada 38x allowing entering in standby
> - Add default trigger for sata led on various linksys boards
> - Update newly added armada-xp-98dx3236
> - Enable hardware buffer manager support for the devices in the
>   Linksys WRT AC Serie
>

Pulled into next/dt, thanks!

       Arnd
