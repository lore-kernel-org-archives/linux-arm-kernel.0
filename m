From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Jun 2017 21:59:52 +0800
Subject: [linux-sunxi] [PATCH v4 3/3] ASoC: sun4i-codec: Add support for
 V3s codec
In-Reply-To: <20170605132722.6459-4-icenowy@aosc.io>
References: <20170605132722.6459-1-icenowy@aosc.io>
 <20170605132722.6459-4-icenowy@aosc.io>
Message-ID: <CAGb2v65xzNOUV+Gm1bL-zXRjWC4SCZd2zQoZzeV+97m_qJX9Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 5, 2017 at 9:27 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
>
> The codec in the V3s is similar to the one found on the A31. One key
> difference is the analog path controls are routed through the PRCM
> block. This is supported by the sun8i-codec-analog driver, and tied
> into this codec driver with the audio card's aux_dev.
>
> In addition, the V3s does not have LINEIN, LINEOUT, MBIAS and MIC2,
> MIC3, and the FIFO related registers are like H3.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
