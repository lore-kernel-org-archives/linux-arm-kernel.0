From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 8 Mar 2017 09:14:24 +0200
Subject: [PATCH v5 2/5] arm: dts: Add the burst and esc clock frequency
 properties to DSI node
In-Reply-To: <1488948852-5380-3-git-send-email-hoegeun.kwon@samsung.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045502epcas1p26f050caaf6eeb79bc88afcb0e2eaeac2@epcas1p2.samsung.com>
 <1488948852-5380-3-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170308071424.a2bdotmsrr7lfmrx@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 01:54:09PM +0900, Hoegeun Kwon wrote:
> Add the burst and esc clock frequency properties to the parent (DSI node).
> Currently the clock is parsed from the port node, while it should be
> taken from the dsi node.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-rinato.dts | 2 ++
>  arch/arm/boot/dts/exynos4210-trats.dts  | 2 ++
>  arch/arm/boot/dts/exynos4412-trats2.dts | 2 ++
>  3 files changed, 6 insertions(+)
>

If anyone needs this, then:


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-clock-dsi-property-4.12

for you to fetch changes up to 4c74ea4e20b582bf90a2cf509d88aa7c2dbffb12:

  ARM: dts: exynos: Add the burst and esc clock frequency properties to DSI node (2017-03-08 09:09:05 +0200)

----------------------------------------------------------------
Add the burst and esc clock frequency properties to DSI node in Exynos ARM
DeviceTree, before the OF graph could be parsed.

----------------------------------------------------------------
Hoegeun Kwon (1):
      ARM: dts: exynos: Add the burst and esc clock frequency properties to DSI node

Jaehoon Chung (1):
      ARM: dts: exynos: Add phy-pcie node for pcie to Exynos5440

Krzysztof Kozlowski (1):
      ARM: dts: exynos: Do not ignore real-world fuse values for thermal zone 0 on Exynos5420

 arch/arm/boot/dts/exynos3250-rinato.dts           |  2 ++
 arch/arm/boot/dts/exynos4210-trats.dts            |  2 ++
 arch/arm/boot/dts/exynos4412-trats2.dts           |  2 ++
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi | 25 +++++++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi                 | 10 ++++----
 arch/arm/boot/dts/exynos5440.dtsi                 | 30 +++++++++++++++--------
 6 files changed, 56 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
