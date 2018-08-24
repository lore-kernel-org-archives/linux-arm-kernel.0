From: horms@verge.net.au (Simon Horman)
Date: Fri, 24 Aug 2018 11:05:03 +0200
Subject: [PATCH 5/5] arm64: dts: renesas: r8a774a1: Add RWDT node
In-Reply-To: <1535014731-64472-6-git-send-email-biju.das@bp.renesas.com>
References: <1535014731-64472-1-git-send-email-biju.das@bp.renesas.com>
 <1535014731-64472-6-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20180824090502.kmip6uvom4zkhed2@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 09:58:51AM +0100, Biju Das wrote:
> Add a device node for the Watchdog Timer (RWDT) controller on the Renesas
> RZ/G2M (r8a774a1) SoC.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Thanks,

This looks fine to me but I will wait to see if there are other reviews
before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
