From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 24 May 2017 18:33:55 +0800
Subject: [linux-sunxi] [PATCH v3 1/9] ASoC: sun8i-codec-analog: split out
 mbias
In-Reply-To: <20170524100607.29790-2-icenowy@aosc.io>
References: <20170524100607.29790-1-icenowy@aosc.io>
 <20170524100607.29790-2-icenowy@aosc.io>
Message-ID: <CAGb2v66iHAMb1gOR9AXqGm3v+bW5ddr-c0oyam4RHDDuVPiDaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 6:05 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
>
> Allwinner V3s features an analog codec without MBIAS pin.
>
> Split out this part, in order to prepare for the V3s analog codec.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
