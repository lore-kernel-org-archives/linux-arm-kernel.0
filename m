From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Feb 2016 20:04:39 +0000
Subject: [PATCH v2 05/10] regulator: axp20x: support AXP809 variant
In-Reply-To: <1455532288-30870-6-git-send-email-wens@csie.org>
References: <1455532288-30870-1-git-send-email-wens@csie.org>
 <1455532288-30870-6-git-send-email-wens@csie.org>
Message-ID: <20160215200439.GC18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 06:31:23PM +0800, Chen-Yu Tsai wrote:
> The X-Powers AXP809 PMIC has a similar set of regulators as the AXP221,
> though a few LDOs were removed, and a new switch output added. Like the
> AXP221, AXP809 also has DC1SW and DC5LDO, which are internally chained
> to DCDC1 and DCDC5, respectively.

This doesn't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160215/05c76f90/attachment.sig>
