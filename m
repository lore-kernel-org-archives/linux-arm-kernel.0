From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sat, 7 Jan 2017 06:26:15 +0900
Subject: [PATCH v5 2/5] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
In-Reply-To: <20170106134350.32428-3-andi.shyti@samsung.com>
References: <CGME20170106134356epcas1p19be459900aec43b2b9ea343cdaf0a2bf@epcas1p1.samsung.com>
 <20170106134350.32428-1-andi.shyti@samsung.com>
 <20170106134350.32428-3-andi.shyti@samsung.com>
Message-ID: <CAGTfZH2-NxEfPDnF987--V3HARm6ZWTeU+qPrhbM3RQ9mBSS=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andi,

2017-01-06 22:43 GMT+09:00 Andi Shyti <andi.shyti@samsung.com>:
> Currently tm2e dts includes tm2 but there are some differences
> between the two boards and tm2 has some properties that tm2e
> doesn't have.
>
> That's why it's important to keep the two dts files independent
> and put all the commonalities in a tm2-common.dtsi file.
>
> At the current status the only two differences between the two
> dts files (besides the board name) are ldo31 and ldo38.
>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>  ...ynos5433-tm2.dts => exynos5433-tm2-common.dtsi} |   21 +-
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1150 +-------------------
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |    2 +-
>  3 files changed, 42 insertions(+), 1131 deletions(-)
>  copy arch/arm64/boot/dts/exynos/{exynos5433-tm2.dts => exynos5433-tm2-common.dtsi} (98%)
>  rewrite arch/arm64/boot/dts/exynos/exynos5433-tm2.dts (98%)

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
