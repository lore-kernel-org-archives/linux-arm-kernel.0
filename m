From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 23 May 2014 03:37:27 +0900
Subject: [PATCH 0/2] ARM: dts: add pmu syscon handle to exynos hdmi nodes
In-Reply-To: <1400593129-21170-1-git-send-email-rahul.sharma@samsung.com>
References: <1400593129-21170-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <537E43E7.407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/14 22:38, Rahul Sharma wrote:
> Add PMU syscon handle to HDMI dt node for controlling PHY
> Enable/Disable bit.
>
> Patch is dependent for following patch for approval on DT
> Bindings:
> http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg31106.html
>
Yeah, I checked above.

Applied this series.

Thanks,
Kukjin

> It is based on Kukjin's "for-next" branch.
>
> Rahul Sharma (2):
>    ARM: dts: add pmu syscon handle to exynos5250 hdmi
>    ARM: dts: add pmu syscon handle to exynos5420 hdmi
>
>   arch/arm/boot/dts/exynos5250.dtsi |    1 +
>   arch/arm/boot/dts/exynos5420.dtsi |    1 +
>   2 files changed, 2 insertions(+)
