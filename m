From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 May 2016 18:36:47 +0100
Subject: [PATCH resend v2 1/6] regulator: axp20x: support AXP809 variant
In-Reply-To: <1464711804-19256-2-git-send-email-wens@csie.org>
References: <1464711804-19256-1-git-send-email-wens@csie.org>
 <1464711804-19256-2-git-send-email-wens@csie.org>
Message-ID: <20160531173647.GJ29837@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 12:23:19AM +0800, Chen-Yu Tsai wrote:
> The X-Powers AXP809 PMIC has a similar set of regulators as the AXP221,
> though a few LDOs were removed, and a new switch output added. Like the
> AXP221, AXP809 also has DC1SW and DC5LDO, which are internally chained
> to DCDC1 and DCDC5, respectively.
> 
> Add support for this new variant. Also remove the "axp22x_" prefix from
> DC1SW/DC5LDO supply handling code, as the AXP809 uses it as well.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Please preserve tags when people review things.  Why wasn't this applied
when I originally reviewed it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160531/14c3e9fd/attachment-0001.sig>
