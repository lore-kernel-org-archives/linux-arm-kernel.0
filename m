From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 8 Mar 2017 09:12:02 +0200
Subject: [PATCH v5 1/5] arm64: dts: exynos: Add the burst and esc clock
 frequency properties to DSI node
In-Reply-To: <1488948852-5380-2-git-send-email-hoegeun.kwon@samsung.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045502epcas1p2b16df118e0ad91dbd2446687dc5ee843@epcas1p2.samsung.com>
 <1488948852-5380-2-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170308071202.6fswc5v4bfwrckzz@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 01:54:08PM +0900, Hoegeun Kwon wrote:
> Add the burst and esc clock frequency properties to the parent (DSI node).
> Currently the clock is parsed from the port node, while it should be
> taken from the dsi node.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

If anyone needs this, then:


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-clock-dsi-property-4.12

for you to fetch changes up to e3c07546747cdec07ff15c984bc6cebc9c9f788c:

  arm64: dts: exynos: Add the burst and esc clock frequency properties to DSI node (2017-03-08 08:55:39 +0200)

----------------------------------------------------------------
Add the burst and esc clock frequency properties to DSI node in Exynos ARM64
DeviceTree, before the OF graph could be parsed.

----------------------------------------------------------------
Andi Shyti (2):
      arm64: dts: exynos: Enable ir-spi in the TM2 and TM2E boards
      arm64: dts: exynos: Add stmfts touchscreen node for TM2 and TM2E

Hoegeun Kwon (1):
      arm64: dts: exynos: Add the burst and esc clock frequency properties to DSI node

Hyungwon Hwang (1):
      arm64: dts: exynos: Add support for S6E3HA2 panel device on TM2 board

 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 43 +++++++++++++++++++++-
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 17 +++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |  7 ++++
 3 files changed, 65 insertions(+), 2 deletions(-)
