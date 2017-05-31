From: robh@kernel.org (Rob Herring)
Date: Wed, 31 May 2017 11:55:35 -0500
Subject: [PATCH v3 3/9] ASoC: sun8i-codec-analog: add support for V3s SoC
In-Reply-To: <20170524100607.29790-4-icenowy@aosc.io>
References: <20170524100607.29790-1-icenowy@aosc.io>
 <20170524100607.29790-4-icenowy@aosc.io>
Message-ID: <20170531165535.bmvsox25akmks2kq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 06:06:01PM +0800, Icenowy Zheng wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
> 
> The V3s SoC features an analog codec with headphone support but without
> mic2 and linein.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt | 1 +
>  sound/soc/sunxi/sun8i-codec-analog.c                           | 9 +++++++++
>  2 files changed, 10 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
