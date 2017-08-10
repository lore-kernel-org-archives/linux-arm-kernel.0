From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Aug 2017 15:21:23 +0800
Subject: [linux-sunxi] [PATCH v2 1/3] arm64: allwinner: a64: enable USB
 host controller for BPi M64
In-Reply-To: <20170725124504.40242-1-icenowy@aosc.io>
References: <20170725124504.40242-1-icenowy@aosc.io>
Message-ID: <CAGb2v66LUku_OmY=Lc8-41oG4PbaKZ=aNVJ2paaQ4GvyJd9VXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 8:45 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Banana Pi M64 connects the USB host-only controller on A64 SoC to a USB
> hub, which provided the two USB Type-A ports on the board.
>
> Enable the USB host controller.
>
> The OTG function of the Micro-USB port needs the drivevbus function of
> the AXP803 driver implemented, so it's not enabled now.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied for 4.14.

Thanks.
