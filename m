From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 30 Dec 2016 16:47:19 +0200
Subject: [PATCH 2/2] ARM: dts: Add CPU OPPs for Exynos4412 Prime
In-Reply-To: <6892749a-a8bd-cfb3-551c-f0b1ca6d2b84@samsung.com>
References: <1483018611-27998-1-git-send-email-b.zolnierkie@samsung.com>
 <1483018611-27998-3-git-send-email-b.zolnierkie@samsung.com>
 <20161229144908.6gkvjpso7ikdmfp7@kozik-lap>
 <CGME20161229150623epcas1p2b2f0fbb6f9ddd11caffdc93487e2cf77@epcas1p2.samsung.com>
 <1840714.lHhVv9oNko@amdc3058>
 <6892749a-a8bd-cfb3-551c-f0b1ca6d2b84@samsung.com>
Message-ID: <20161230144719.amcn3q4vn6wgxnon@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 05:23:34PM +0100, Sylwester Nawrocki wrote:
> On 12/29/2016 04:06 PM, Bartlomiej Zolnierkiewicz wrote:
> >>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>> ---
> >>>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  4 +--
> >>>  arch/arm/boot/dts/exynos4412-odroidu3.dts       |  5 +--
> >>>  arch/arm/boot/dts/exynos4412-odroidx2.dts       |  1 +
> >>>  arch/arm/boot/dts/exynos4412-prime.dtsi         | 41 +++++++++++++++++++++++++
> >>>  arch/arm/boot/dts/exynos4412.dtsi               |  2 +-
> >>>  5 files changed, 48 insertions(+), 5 deletions(-)
> >>>  create mode 100644 arch/arm/boot/dts/exynos4412-prime.dtsi
> >>>
> >> Looks okay. Is the clock patch needed for this?
> > Yep.
> 
> I applied the clock patch and here is a stable tag if it needs
> to be pulled as a dependency.
>

Thanks, merged!

BR,
Krzysztof
