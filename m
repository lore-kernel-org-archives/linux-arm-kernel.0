From: horms@verge.net.au (Simon Horman)
Date: Wed, 13 Dec 2017 10:02:40 +0100
Subject: [PATCH 0/5] Add Sound support for iWave RZ/G1M board
In-Reply-To: <1513103111-45830-1-git-send-email-biju.das@bp.renesas.com>
References: <1513103111-45830-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20171213090240.xqgihh4bqsfzeaip@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 06:25:06PM +0000, Biju Das wrote:
> This series aims to add sound support for iWave RZ/G1M board.
> 
> This patch series has documentation dependency on 
> https://patchwork.kernel.org/patch/10108014/
> 
> Biju Das (5):
>   ARM: shmobile: defconfig: Enable SGTL5000 audio codec
>   ARM: dts: r8a7743: Add audio clocks
>   ARM: dts: r8a7743: Add audio DMAC support
>   ARM: dts: r8a7743: Add sound support
>   ARM: dts: iwg20d-q7-common: Enable SGTL5000 audio codec
> 
>  arch/arm/boot/dts/iwg20d-q7-common.dtsi |  24 +++
>  arch/arm/boot/dts/r8a7743.dtsi          | 270 ++++++++++++++++++++++++++++++++
>  arch/arm/configs/shmobile_defconfig     |   1 +
>  3 files changed, 295 insertions(+)

These patches seem clean to me although I do not have sufficient
documentation to properly review the last patch.

I will leave these sit for a few days to allow others to review them.
