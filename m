From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Mar 2016 12:27:38 -0500
Subject: [PATCH v2 16/18] dt-bindings: Add OXNAS bindings
In-Reply-To: <1457519060-6038-17-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-17-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160317172738.GA7293@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 11:24:18AM +0100, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/oxnas.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
> new file mode 100644
> index 0000000..f6032d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/oxnas.txt
> @@ -0,0 +1,9 @@
> +PLX Technology OXNAS SoCs Family device tree bindings
> +-------------------------------------------
> +
> +Boards with the OX810SE Soc SoC shall have the following properties:

s/Soc SoC/SoC/

> +  Required root node property:
> +    compatible: "oxsemi,ox810se"
> +
> +Board compatible values:
> +  - "wd,mbwe" (OX810SE)

Seems kind of generic. Only one version?

> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
