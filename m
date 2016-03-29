From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Mar 2016 09:09:57 -0700
Subject: [PATCH resend v2 4/9] regulator: axp20x: support AXP809 variant
In-Reply-To: <1459243352-23344-5-git-send-email-wens@csie.org>
References: <1459243352-23344-1-git-send-email-wens@csie.org>
 <1459243352-23344-5-git-send-email-wens@csie.org>
Message-ID: <20160329160957.GO2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 05:22:27PM +0800, Chen-Yu Tsai wrote:
> The X-Powers AXP809 PMIC has a similar set of regulators as the AXP221,
> though a few LDOs were removed, and a new switch output added. Like the
> AXP221, AXP809 also has DC1SW and DC5LDO, which are internally chained
> to DCDC1 and DCDC5, respectively.

Reviewed-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/5971c247/attachment.sig>
