From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Feb 2016 17:15:03 +0000
Subject: [PATCH 06/11] regulator: axp20x: support AXP809 variant
In-Reply-To: <1454408864-24112-7-git-send-email-wens@csie.org>
References: <1454408864-24112-1-git-send-email-wens@csie.org>
 <1454408864-24112-7-git-send-email-wens@csie.org>
Message-ID: <20160203171503.GH4455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 06:27:39PM +0800, Chen-Yu Tsai wrote:
> The X-Powers AXP809 PMIC has a similar set of regulators as the AXP221,
> though a few LDOs were removed, and a new switch output added. Like the
> AXP221, AXP809 also has DC1SW and DC5LDO, which are internally chained
> to DCDC1 and DCDC5, respectively.

This looks OK to me.  Will there be a branch with the new IDs in it that
I can pull in to apply it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/8b6473ba/attachment.sig>
