From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Apr 2018 16:37:30 -0500
Subject: [RFC 1/3] dt-bindings: cpu: Add Renesas RZ/N1D SMP enable method.
In-Reply-To: <1523871304-48517-3-git-send-email-michel.pollet@bp.renesas.com>
References: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523871304-48517-3-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <20180416213730.isfggqngv6zjxahg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 10:34:57AM +0100, Michel Pollet wrote:
> Add a special enable method for second CA8 of the Renesas RZ/N1D
> (R9A06G032).
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
