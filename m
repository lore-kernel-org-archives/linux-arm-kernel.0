From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Mar 2015 17:09:41 +0100
Subject: [PATCH v7 1/9] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <1426637856-3730-2-git-send-email-cw00.choi@samsung.com>
References: <1426637856-3730-1-git-send-email-cw00.choi@samsung.com>
 <1426637856-3730-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <20150330160940.GA13731@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 18, 2015 at 12:17:28AM +0000, Chanwoo Choi wrote:
> This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC based on
> Octal core CPUs (quad Cortex-A57 and quad Cortex-A53). And Exynos5433 supports
> PSCI (Power State Coordination Interface) v0.1.
> 
> This patch includes following dt node to support Exynos5433 SoC:
> 1. Octa core for big.LITTLE architecture
> - Cortex-A53 LITTLE Quad-core
> - Cortex-A57 big Quad-core
> - Support PSCI v0.1

Is CPU0 hotplug still broken, or has the FW been fixed?

I'm very worried about adding a DT that's known broken, especially when
we have no idea as to if/when the FW will be fixed judging from prior
replies.

Mark.
