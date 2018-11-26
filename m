From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 Nov 2018 16:58:22 +0000
Subject: [PATCH 07/14] dt-bindings: mfd: axp20x: Add software based
 soft_start for AXP209 LDO3
In-Reply-To: <2cd75ee27982f3be0d86104d80eaa13efeb2c65d.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <2cd75ee27982f3be0d86104d80eaa13efeb2c65d.1543245984.git-series.plaes@plaes.org>
Message-ID: <20181126165822.GJ9715@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 05:27:48PM +0200, Priit Laes wrote:

> +- regulator-soft-start:	enable the output at the lowest possible voltage and
> +			only then set the desired voltage
> +			AXP20x/LDO3

This is a generic property, there is no need to document it in each
device binding.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181126/12232943/attachment.sig>
