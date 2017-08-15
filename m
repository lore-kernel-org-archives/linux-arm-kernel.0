From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Aug 2017 18:04:52 +0200
Subject: [GIT PULL] ARM: mvebu: arm64 for v4.14 (#1)
In-Reply-To: <877eyaif39.fsf@free-electrons.com>
References: <877eyaif39.fsf@free-electrons.com>
Message-ID: <CAK8P3a1r0NtO0WM2OXXikaO-bLym8D=9unXMayhcaiuKdzJ=+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 12:16 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi,
>
> Here is the first pull request for arm64 for mvebu for v4.14.
>
> Gregory
>
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>
> are available in the git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-arm64-4.14-1
>
> for you to fetch changes up to a168f2a80458095ccdc03ea777d5d469be3934ed:
>
>   arm64: defconfig: enable fine-grained task level IRQ time accounting (2017-08-03 14:25:52 +0200)
>
> ----------------------------------------------------------------
> mvebu arm64 for 4.14 (part 1)
>
> Enabling nop-xceiv PHY driver in the defconfig, needed for USB support
> on A8K SoC based board.
>
> Enabling fine-grained task level IRQ time accounting for ARMv8 as it was
> already done for x86

Pulled into next/arm64, thanks!

     Arnd
