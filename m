From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 5 Jun 2017 21:15:07 +0800
Subject: [linux-sunxi] [PATCH 1/2] dmaengine: sun6i: make gate bit in
 sun8i's DMA engines a common quirk
In-Reply-To: <20170605123348.26137-2-icenowy@aosc.io>
References: <20170605123348.26137-1-icenowy@aosc.io>
 <20170605123348.26137-2-icenowy@aosc.io>
Message-ID: <CAGb2v65ceuUctYQHEeMa9TA49pX-yB3RGr8CMi8d2WLeuDcvjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 5, 2017 at 8:33 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
>
> Originally we enable a special gate bit when the compatible indicates
> A23/33.
>
> But according to BSP sources and user manuals, more SoCs will need this
> gate bit.
>
> So make it a common quirk configured in the config struct.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
