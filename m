From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Nov 2014 23:31:58 +0000
Subject: [PATCH 4/7] dt-bindings: Add document for MT6397 MFD
In-Reply-To: <1416210027-5562-5-git-send-email-flora.fu@mediatek.com>
References: <1416210027-5562-1-git-send-email-flora.fu@mediatek.com>
 <1416210027-5562-5-git-send-email-flora.fu@mediatek.com>
Message-ID: <20141117233158.GD22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 03:40:24PM +0800, Flora Fu wrote:

> +		pmic {
> +			compatible = "mediatek,mt6397";
> +	}

This looks like it's missing a closing brace and is just generally weird
(having a subnode like this).

> +- regulators : The regulators of mt6397
> +	regulators {
> +		regulator constratints.
> +		refer Documentation/devicetree/bindings/regulator/regulator.txt
> +	};

You need to define the set of valid regulator names and how that maps
onto the physical device, look at other regulator binding documents for
examples.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/80be6512/attachment.sig>
