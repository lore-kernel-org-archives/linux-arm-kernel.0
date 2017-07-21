From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Jul 2017 15:34:05 +0800
Subject: [linux-sunxi] [PATCH 1/3] arm64: allwinner: a64: enable USB host
 controller for BPi M64
In-Reply-To: <20170720230717.58255-1-icenowy@aosc.io>
References: <20170720230717.58255-1-icenowy@aosc.io>
Message-ID: <CAGb2v65kin89iDFtqZFwXvsb1YVjStcgJOY7yZa0Q2VVecsOkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 7:07 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Banana Pi M64 connects the USB host-only controller on A64 SoC to a USB
> hub, which provided the two USB Type-A ports on the board.
>
> Enable the USB host controller.
>
> The OTG function of the Micro-USB port needs the drivevbus function of
> the AXP803 driver implemented, so it's not enabled now.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
