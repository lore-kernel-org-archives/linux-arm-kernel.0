From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 16:22:32 -0700
Subject: [PATCH 1/7] reset: sunxi: document sunxi's reset controllers
 bindings
In-Reply-To: <1398697130-8338-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1398697130-8338-1-git-send-email-boris.brezillon@free-electrons.com>
 <1398697130-8338-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140428232232.GP3134@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Mon, Apr 28, 2014 at 04:58:44PM +0200, Boris BREZILLON wrote:
> Add DT bindings documentation for sunxi's reset controllers.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  .../bindings/reset/allwinner,sunxi-clock-reset.txt  | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt b/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
> new file mode 100644
> index 0000000..a582804
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
> @@ -0,0 +1,21 @@
> +Allwinner sunxi Peripheral Reset Controller
> +===========================================
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible: Should be one of the following depending on your SoC:

It doesn't really depend on the SoC.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/fa8af110/attachment.sig>
