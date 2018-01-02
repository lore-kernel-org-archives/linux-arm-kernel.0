From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 2 Jan 2018 16:11:04 +0800
Subject: [linux-sunxi] [PATCH v4 1/6] ARM: sunxi: h3/h5: add simplefb nodes
In-Reply-To: <20171230113043.30237-2-icenowy@aosc.io>
References: <20171230113043.30237-1-icenowy@aosc.io>
 <20171230113043.30237-2-icenowy@aosc.io>
Message-ID: <CAGb2v64V7KYw5W95-E=b=Li13ZFXy7JakK4+Dx1dsrXXSJZ+wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 30, 2017 at 7:30 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The H3/H5 SoCs have a HDMI output and a TV Composite output.
>
> Add simplefb nodes for these outputs.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v4:
> - Dropped extra clocks (bus clocks and HDMI DDC clocks), only keep the
>   clocks that are needed to display framebuffer to the monitor.

Looks good. I assume you've tested this? It does continue to work
with the bus and DDC clocks disabled, right?

Thanks
ChenYu
