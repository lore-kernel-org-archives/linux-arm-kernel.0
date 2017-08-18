From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 22:41:07 +0200
Subject: [GIT PULL] arm: mediatek: dts32 updates for v4.14
In-Reply-To: <9434dcb8-d38d-ff3a-a6ce-2b27d3a74cef@gmail.com>
References: <9434dcb8-d38d-ff3a-a6ce-2b27d3a74cef@gmail.com>
Message-ID: <CAK8P3a0HnyJq4LUQyv8zn5vKcybyY3avam8s=6UFcMSeqXVQbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 3:37 PM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>
> are available in the git repository at:
>
>   https://github.com/mbgg/linux-mediatek.git tags/v4.13-next-dts64
>
> for you to fetch changes up to bdf2cbb2b3160122f7ff16445fdb73267fffd583:
>
>   arm64: dts: Add Mediatek SoC MT2712 and evaluation board dts and Makefile
> (2017-08-17 15:33:45 +0200)
>
> ----------------------------------------------------------------
> - add SoC mt7622 and its reference board
> - cleanup of dts bindings
> - mt6797: add watchdog and delete unused clock
> - add support for SoC mt2701 and it's eval board

Nice to see mt7622 support already getting merged, at least it seems this
is getting there before the chip ends up in consumer devices, normally
it's the other way round ;-)

Could you let me know what mt2712 is? I can't find anything about this
chip, not even which business unit made it, and I'd like to have a brief
description for most newly added hardware in my own pull requests.

        Arnd
