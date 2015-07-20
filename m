From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Jul 2015 18:28:28 +0100
Subject: [PATCH 1/2] dt-bindings: Add document for MT6311 regulator
In-Reply-To: <1437377793-31558-2-git-send-email-henryc.chen@mediatek.com>
References: <1437377793-31558-1-git-send-email-henryc.chen@mediatek.com>
 <1437377793-31558-2-git-send-email-henryc.chen@mediatek.com>
Message-ID: <20150720172828.GG11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 03:36:32PM +0800, Henry Chen wrote:

> +Required properties:
> +- compatible: "mediatek,mt6311-regulator"
> +- mt6311regulator: List of regulators provided by this controller. It is named
> +  to VDVFS and VBIASN.

Why this weird property name?  It looks like it might just be a typo and
should just be "regulator"?

Please use subject lines reflecting the style for the subsystem, it
helps people find patches that are relevant to them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/d39e4523/attachment.sig>
