From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 18 May 2017 15:40:00 +0800
Subject: [linux-sunxi] [PATCH v6 1/9] irqchip/sunxi-nmi: add A64 R_INTC to
 the binding doc
In-Reply-To: <20170518071653.36561-2-icenowy@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
 <20170518071653.36561-2-icenowy@aosc.io>
Message-ID: <CAGb2v662ptzp2-J_H1qrXVVBK5S2aYATbbM1StToOz-OideD_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 3:16 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The A31 NMI driver seems to be using wrong base address.
>
> As we're going to convert to use a correct NMI base address (and
> correctly name it to R_INTC as the datasheet suggests), add a new
> compatible string for the "correct" R_INTC, which we will use for A64
> SoC.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Rob Herring <robh@kernel.org>

The subject prefix might need a bit of work, but otherwise

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
