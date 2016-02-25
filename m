From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 16:56:08 -0800
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.6 (#1)
In-Reply-To: <877fi3s48z.fsf@free-electrons.com>
References: <877fi3s48z.fsf@free-electrons.com>
Message-ID: <20160225005608.GB29055@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 05:14:52PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for dt64 for mvebu for v4.6.
> 
> This is the second part of the Armada 3700 series[1]. This part is
> easier to handle as there is no dependency. As for the other one, let me
> know if I should do it in a different way.
> 
> Thanks,
> 
> Gregory
> 
> [1]: https://lkml.org/lkml/2016/2/16/735
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.6-1
> 
> for you to fetch changes up to adbc3695d9e487fa07214140a46b68ac3156fb78:
> 
>   arm64: dts: add the Marvell Armada 3700 family and a development board (2016-02-17 16:09:55 +0100)
> 
> ----------------------------------------------------------------
> mvebu dt64 for 4.6 (part 1)
> 
> Device tree part of the Armada 3700 support:
> - binding for the Armada 3700 SoCs
> - device tree files for the SoCs and a board
> - tidy up the Marvell related files
> 
> ----------------------------------------------------------------
> Gregory CLEMENT (4):
>       Documentation: dt-bindings: Add a new compatible for the Armada 3700
>       Documentation: dt: Tidy up the Marvell related files
>       devicetree: bindings: add DT binding for the Marvell Armada 3700 SoC family
>       arm64: dts: add the Marvell Armada 3700 family and a development board

Merged, thanks.

In the future, please use arm64: dts: marvell: ...


-Olof
