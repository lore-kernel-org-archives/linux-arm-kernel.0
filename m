From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 5 Sep 2018 12:56:03 +0530
Subject: [linux-sunxi] [PATCH v4 11/11] arm64: dts: allwinner: a64: Enable
 HDMI output on A64 boards w/ HDMI
In-Reply-To: <20180904044053.15425-12-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-12-icenowy@aosc.io>
Message-ID: <CAMty3ZCvpUf0nJ3WuPccP8BizBP=Uc8ChzB8SeN8fkX2iS1E_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>
> Enable all necessary device tree nodes and add connector node to device
> trees for all supported A64 boards with HDMI.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> [Icenowy: squash all board patches altogether and change supply name]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v4:
> - Rebase some device trees.
> Changes in v3,1:
> - Squash all enablement patches altogether.
> - Change supply name to match DT binding & driver change.
> Changes for v3:
> - Enable all pipeline components
> Changes for v2:
> - none
>
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 34 +++++++++++++++++++
>  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 34 +++++++++++++++++++
>  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 34 +++++++++++++++++++
>  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 34 +++++++++++++++++++
>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 34 +++++++++++++++++++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts | 34 +++++++++++++++++++
>  6 files changed, 204 insertions(+)

Tested-by: Jagan Teki <jagan@amarulasolutions.com> # BPI-M64, OPI-Win,
A64-Olinuxino, NPI-A64

Pine64 boards look unable by saying
[drm] Cannot find any crtc or sizes

May be someone can confirm, it.
