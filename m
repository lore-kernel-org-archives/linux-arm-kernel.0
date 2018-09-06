From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 6 Sep 2018 11:48:13 +0530
Subject: [linux-sunxi] [PATCH v4 08/11] arm64: dts: allwinner: a64: Add
 display pipeline
In-Reply-To: <20180904044053.15425-9-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-9-icenowy@aosc.io>
Message-ID: <CAMty3ZDn=uj3buvJx93R1J7Swr3CyfjJJ=MgQTGvRZ01izbAAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
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
> ---
> Changes for v4:
> - Misc fixes
> - Dropped second PLL from HDMI PHY clock

Why? it was there in previous versions.
