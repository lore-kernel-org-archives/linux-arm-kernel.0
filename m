From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 10 Nov 2017 11:21:25 +0800
Subject: [PATCH v2 0/2] Add dwmac-sun8i on A83T DT
In-Reply-To: <20171109082950.21124-1-clabbe.montjoie@gmail.com>
References: <20171109082950.21124-1-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v64=wj2C3T1CXM3Kh-nP71rJqdCwaCAAMtc6hBJzc9i8pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 9, 2017 at 4:29 PM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> Hello
>
> This patch series add some device node for dwmac-sun8i on A83T.
>
> Changes since v1:
> - reworked commit log of patch #1
> - added comment on drive strength
>
> Corentin Labbe (2):
>   ARM: sun8i: a83t: add dwmac-sun8i device node
>   ARM: sun8i: bananapi-m3: Enable dwmac-sun8i

Subjects should have "dts:" prefix.
We could probably fix it up for you.

ChenYu

>
>  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 18 +++++++++++++++
>  arch/arm/boot/dts/sun8i-a83t.dtsi            | 33 ++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> --
> 2.13.6
>
