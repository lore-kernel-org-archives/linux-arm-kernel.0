From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 21 Feb 2016 11:09:17 +0100
Subject: [GIT PULL] ARM: mvebu: fixes for v4.5 (#2)
In-Reply-To: <874mdfxkjx.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Thu, 11 Feb 2016 17:45:38 +0100")
References: <874mdfxkjx.fsf@free-electrons.com>
Message-ID: <874md2pe7m.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On jeu., f?vr. 11 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi,
>
> Here is the second pull request for fixes for mvebu for v4.5.
>

I didn't see these 2 commits in v4.5-rc4 or v4.5-rc5. So I wanted to
check that you didn't miss this PR.

Thanks,

Gregory


>
> The following changes since commit ff61ee84e7aa5842d9e33c0b442f0b43a6a44eaf:
>
>   ARM: dts: orion5x: gpio pin fixes for linkstation lswtgl (2016-01-25 16:22:59 +0100)
>
> are available in the git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.5-2
>
> for you to fetch changes up to 44361a2cc13493fc41216d33bb9a562ec3a9cc4e:
>
>   ARM: dts: orion5x: fix the missing mtd flash on linkstation lswtgl (2016-02-09 11:17:53 +0100)
>
> ----------------------------------------------------------------
> mvebu fixes for 4.5 (part 2)
>
> - Fix the missing mtd flash on linkstation lswtgl
> - Use unique machine name for the kirkwood ds112 (for Debian flash-kernel tool)
>
> ----------------------------------------------------------------
> Heinrich Schuchardt (1):
>       ARM: dts: kirkwood: use unique machine name for ds112
>
> Roger Shimizu (1):
>       ARM: dts: orion5x: fix the missing mtd flash on linkstation lswtgl
>
>  arch/arm/boot/dts/kirkwood-ds112.dts             |  2 +-
>  arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 31 ++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
