From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 9 Apr 2018 15:33:34 +0800
Subject: [linux-sunxi] [PATCH v3] ARM: sun8i: v40: enable USB host ports
 for Banana Pi M2 Berry
In-Reply-To: <20180406140344.9457-1-icenowy@aosc.io>
References: <20180406140344.9457-1-icenowy@aosc.io>
Message-ID: <CAGb2v651vpy3jdFY56CQi4yBU1wh01ecPn9cO9fiXkfed35QDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 6, 2018 at 10:03 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Banana Pi M2 Berry has an on-board USB Hub that provides 4 USB Type-A
> ports, and it's connected to the USB1 port of the SoC.
>
> Enable it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Verified against public schematics.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
