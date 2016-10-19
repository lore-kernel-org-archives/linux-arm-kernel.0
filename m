From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 19 Oct 2016 14:39:27 +0200
Subject: [PATCH v2 5/9] of: Add vendor prefix for Netron DY
In-Reply-To: <20160906144620.6322-6-maxime.ripard@free-electrons.com>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
 <20160906144620.6322-6-maxime.ripard@free-electrons.com>
Message-ID: <20161019123927.GE16158@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 04:46:16PM +0200, Maxime Ripard wrote:
> Netron DY is a brand of LCD panels found on SBCs and tablets.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Hi Rob,

care to give this your Acked-by?

Thanks,
Thierry

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 1992aa97d45a..9c1ab3c1132b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -176,6 +176,7 @@ nec	NEC LCD Technologies, Ltd.
>  neonode		Neonode Inc.
>  netgear	NETGEAR
>  netlogic	Broadcom Corporation (formerly NetLogic Microsystems)
> +netron-dy	Netron DY
>  netxeon		Shenzhen Netxeon Technology CO., LTD
>  newhaven	Newhaven Display International
>  nintendo	Nintendo
> -- 
> 2.9.3
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161019/8e2680c2/attachment-0001.sig>
