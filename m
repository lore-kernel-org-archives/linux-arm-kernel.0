From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Feb 2015 09:33:45 +0100
Subject: [PATCH v4 2/8] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <1424755011-15999-3-git-send-email-cw00.choi@samsung.com>
References: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
 <1424755011-15999-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <19309272.tlWX2xvTnx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 14:16:45 Chanwoo Choi wrote:
> This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC based on
> Octal core CPUs (quad Cortex-A57 and quad Cortex-A53). And Exynos5433 supports
> PSCI (Power State Coordination Interface) v0.1.
> 
> This patch includes following dt node to support Exynos5433 SoC:
> 1. Octa core for big.LITTLE architecture
> - Cortex-A53 LITTLE Quad-core
> - Cortex-A57 big Quad-core
> - Support PSCI v0.1

Should we try to come up with a way to better share parts of this with the
exynos5 dtsi files you already have in arm32? I suspect that there is a
significant overlap.

	Arnd
