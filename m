From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jan 2017 22:30:52 -0800
Subject: [GIT PULL 2/4] ARM: dts: exynos: DT for v4.11
In-Reply-To: <20170113152030.13586-2-krzk@kernel.org>
References: <20170113152030.13586-1-krzk@kernel.org>
 <20170113152030.13586-2-krzk@kernel.org>
Message-ID: <20170117063052.GM16607@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 05:20:28PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Few improvements and Exynos4412 DTSI removal.
> 
> This pulls external dependecy from clock tree (one clock commit).
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.11
> 
> for you to fetch changes up to bca9085e0ae93253bc93ce218c85ac7d7e7f1831:
> 
>   ARM: dts: exynos: remove Exynos4212 support (dead code) (2017-01-11 18:28:43 +0200)
> 
> ----------------------------------------------------------------
> Samsung DeviceTree update for v4.11:
> 1. Fixes for initial audio clocks configuration.
> 2. Enable sound on Odroid-X board.
> 3. Enable DMA for UART modules on Exynos5 SoCs.
> 4. Add CPU OPPs for Exynos4412 Prime (newer version of Exynos4412). This pulls
>    necessary change in the clocks.
> 5. Remove Exynos4212. We do not have any mainline boards with it. This will
>    simplify few bits later.

Merged, thanks.


-Olof
