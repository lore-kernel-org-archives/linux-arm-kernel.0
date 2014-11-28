From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Nov 2014 15:30:56 +0000
Subject: [PATCH v2 6/8] dt-bindings: Add document for MT6397 regulator
In-Reply-To: <1417146874-5232-7-git-send-email-flora.fu@mediatek.com>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
 <1417146874-5232-7-git-send-email-flora.fu@mediatek.com>
Message-ID: <20141128153056.GT7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 11:54:32AM +0800, Flora Fu wrote:

> +- compatible: "mediatek,mt6397"
> +- regulators: This is the list of child nodes that specify the regulator
> +  initialization data for defined regulators. The definition for each of these
> +  nodes is defined using the standard binding for regulators found at
> +  Documentation/devicetree/bindings/regulator/regulator.txt.

You need to specify which regulator names are valid and how they
correspond to the hardware as part of the binding.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/91b3422b/attachment-0001.sig>
