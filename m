From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 May 2017 11:58:37 +0800
Subject: [linux-sunxi] [PATCH v3 3/9] ASoC: sun8i-codec-analog: add
 support for V3s SoC
In-Reply-To: <20170524100607.29790-4-icenowy@aosc.io>
References: <20170524100607.29790-1-icenowy@aosc.io>
 <20170524100607.29790-4-icenowy@aosc.io>
Message-ID: <CAGb2v673VPeF+KOZskWnHppWSMvZSfLS5JXxxSjM9diDF7NGeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 6:06 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
>
> The V3s SoC features an analog codec with headphone support but without
> mic2 and linein.
>
> Add support for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Mark, please hold off on applying this patch until the comments from the
previous patch have been addressed. They should be applied in order.

> ---
>  Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt | 1 +
>  sound/soc/sunxi/sun8i-codec-analog.c                           | 9 +++++++++

Also, is there a preference for splitting out device tree binding
changes from driver changes?

Thanks
ChenYu
