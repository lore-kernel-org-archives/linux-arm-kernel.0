From: broonie@kernel.org (Mark Brown)
Date: Sat, 19 Sep 2015 11:06:30 -0700
Subject: [PATCH 1/3] mfd: axp20x: Rename supply names for AXP221 DC1SW
 and DC5LDO regulators
In-Reply-To: <1442372732-27434-2-git-send-email-wens@csie.org>
References: <1442372732-27434-1-git-send-email-wens@csie.org>
 <1442372732-27434-2-git-send-email-wens@csie.org>
Message-ID: <20150919180630.GN30445@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 11:05:30AM +0800, Chen-Yu Tsai wrote:
> The DC1SW and DC5LDO regulators in the AXP221 are internally chained
> to DCDC1 and DCDC5, hence the names. The original bindings used the
> parent regulator names for the supply regulator property. This causes
> some confusion when we actually use it in the dts:

If these regulators are internally always connected to other regulators
in the same device why are we even representing their supplies in DT?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150919/a3bfa007/attachment.sig>
