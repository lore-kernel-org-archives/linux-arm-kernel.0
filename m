From: robh@kernel.org (Rob Herring)
Date: Sun, 26 Nov 2017 16:29:05 -0600
Subject: [PATCH] arm64: renesas: document V3MSK board bindings
In-Reply-To: <20171124204748.920422106@cogentembedded.com>
References: <20171124204748.920422106@cogentembedded.com>
Message-ID: <20171126222905.62qkvnvep2rkqcb6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 11:47:39PM +0300, Sergei Shtylyov wrote:
> Document the V3M Starter Kit device tree bindings, listing it as
> a supported board.
> 
> This allows to use checkpatch.pl to validate .dts files referring to
> the V3MSK board.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt |    2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
