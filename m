From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 25 Sep 2018 18:29:48 +0800
Subject: [PATCH v5 1/2] arm64: dts: allwinner: a64: Add display pipeline
In-Reply-To: <20180925084940.27903-1-jagan@amarulasolutions.com>
References: <20180925084940.27903-1-jagan@amarulasolutions.com>
Message-ID: <CAGb2v64vzD5y5PMRscfWkdh+7b=KUJFf0chvOpsrw6XTg+_YYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 4:49 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Allwinner A64 have a display pipeline with 2 mixers/TCONs, the first
> TCON is connected to LCD and the second is to HDMI.
>
> The HDMI controller/PHY pair is similar to the one on H3/H5.
>
> Add all required device tree nodes of the display pipeline, including
> the TCON0 LCD one and the TCON1 HDMI one.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> [Icenowy: refactor commit message and add 1st pipeline]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Merged both patches for 4.20. Thanks.
