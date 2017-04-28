From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Apr 2017 15:51:43 -0500
Subject: [PATCH v5 02/10] irqchip/sunxi-nmi: add A64 R_INTC to the
 binding doc
In-Reply-To: <20170426152023.41567-3-icenowy@aosc.io>
References: <20170426152023.41567-1-icenowy@aosc.io>
 <20170426152023.41567-3-icenowy@aosc.io>
Message-ID: <20170428205143.gybvmju4675l2g35@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 11:20:15PM +0800, Icenowy Zheng wrote:
> The A31 NMI driver seems to be using wrong base address.
> 
> As we're going to convert to use a correct NMI base address (and
> correctly name it to R_INTC as the datasheet suggests), add a new
> compatible string for the "correct" R_INTC, which we will use for A64
> SoC.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../bindings/interrupt-controller/allwinner,sunxi-nmi.txt          | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
