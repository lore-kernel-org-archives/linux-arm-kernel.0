From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Oct 2018 17:24:30 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.20 (#2)
In-Reply-To: <87woqxlmyo.fsf@bootlin.com>
References: <87woqxlmyo.fsf@bootlin.com>
Message-ID: <CAK8P3a0CJAy0BhFG5z4siEZi9M5YLMA=ZRge+h4uHSfCp1pqFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 4, 2018 at 6:02 PM Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
>
> Hi,
>
> Here is the second pull request for dt64 for mvebu for v4.20. It comes
> later that usual but the driver part of the System Error Interrupt
> support was accepted only on the beginning of the week. And while I
> was on adding more dts patch, I also add the CPU idle patches that
> were pending since a few weeks.
>
> Gregory
>
> The following changes since commit 620cfb31bad4c5be7d9250f1e47a592750fc364b:
>
>   arm64: dts: marvell: armada-37xx: add nodes to support watchdog (2018-09-28 10:00:17 +0200)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.20-2
>
> for you to fetch changes up to 91f84690b502075550ca01d853d5c49b319921eb:
>
>   arm64: dts: clearfog-gt-8k: add PCIe slot description (2018-10-03 17:22:34 +0200)
>
> ----------------------------------------------------------------
> mvebu dt64 for 4.20 (part 2)
>
>  - Add System Error Interrupt support to Armada SoCs (7K/8K)
>  - Add CPU idle support on Armada 8K
Pulled into next/dt, thanks!

       Arnd
