From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 3 Dec 2014 14:18:25 +0200
Subject: [PATCH v3 2/3] Documentation: DT: Add documentation for ti, opa362
 bindings
In-Reply-To: <1417352867-7436-3-git-send-email-marek@goldelico.com>
References: <1417352867-7436-1-git-send-email-marek@goldelico.com>
 <1417352867-7436-3-git-send-email-marek@goldelico.com>
Message-ID: <547EFF91.7040405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/14 15:07, Marek Belisko wrote:
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  .../devicetree/bindings/video/ti,opa362.txt        | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/ti,opa362.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/ti,opa362.txt b/Documentation/devicetree/bindings/video/ti,opa362.txt
> new file mode 100644
> index 0000000..4747ef9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/ti,opa362.txt
> @@ -0,0 +1,38 @@
> +OPA362 analog video amplifier
> +
> +Required properties:
> +- compatible: "ti,opa362"
> +- gpio: enable/disable output gpio

Either this or the example is wrong. If I'm not mistaken 'gpios' is the
correct form.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141203/caabacf1/attachment.sig>
