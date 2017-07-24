From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 24 Jul 2017 14:07:08 +0800
Subject: [linux-sunxi] [PATCH v3 4/5] ARM: sun8i: h3: add support for the
 thermal sensor in H3
In-Reply-To: <20170723141354.42646-5-icenowy@aosc.io>
References: <20170723141354.42646-1-icenowy@aosc.io>
 <20170723141354.42646-5-icenowy@aosc.io>
Message-ID: <CAGb2v677mjrwN5-0A0cxFQthkCOHqrSwQmAgXreBLo8oPWj14g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 23, 2017 at 10:13 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> As we have gained the support for the thermal sensor in H3, we can now
> add its device nodes to the device tree.
>
> Add them to the H3 device tree.
>
> The H5 thermal sensor has some differences, and will be added furtherly.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Other than the possibility of referencing e-fuses for calibration data,
this patch looks good.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
