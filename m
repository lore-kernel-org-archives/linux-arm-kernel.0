From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 9 Mar 2018 13:54:26 +0100
Subject: [PATCH 1/4] ARM: dts: exynos5250: Add #sound-dai-cells property
 to hdmi device node
In-Reply-To: <20180307172711.15697-1-s.nawrocki@samsung.com>
References: <CGME20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56@epcas1p1.samsung.com>
 <20180307172711.15697-1-s.nawrocki@samsung.com>
Message-ID: <CAJKOXPdgsNwcVQ0FZLDR_q8Dz1AkSEBaG-1Mij7TKSLpSRJLpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2018 at 6:27 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> This property is required for specifying link between the HDMI IP block
> and the SoC's audio subsystem.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Subject prefix:
ARM: dts: exynos: Add..... to Exynos5250

Please fix it here and in other places. For arm64 prefix is slightly
different (arm64: dts: exynos:). I did not notice that in your last
patches and applied them but please take care about this in future.

In case you forget how the prefix should look like - run "git log
--oneline -- arch/arm/boot/dts/exynos*" or "git log --oneline --
arch/arm64/boot/dts/exynos/".

BR,
Krzysztof
