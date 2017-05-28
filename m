From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 28 May 2017 22:58:34 +0800
Subject: [PATCH v3 02/10] pinctrl: sunxi: Add SoC ID definitions for A10,
 A20 and R40 SoCs
In-Reply-To: <20170527102308.1988-3-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
 <20170527102308.1988-3-icenowy@aosc.io>
Message-ID: <CAGb2v67YigaybOqiHJ-cSF4vNvkP7xBgt2jTd4NHdyGfB75kEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 6:23 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner A10, A20 and R40 SoCs have similar GPIO layout.
>
> Add SoC definitions in pinctrl-sunxi.h, in order to merge A20 support
> into A10 driver, and add R40 support into it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
