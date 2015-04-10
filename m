From: broonie@kernel.org (Mark Brown)
Date: Fri, 10 Apr 2015 16:48:09 +0100
Subject: [PATCH RESEND v6 4/6] regulator: axp20x: add support for AXP22X
 regulators
In-Reply-To: <1428638946-24890-5-git-send-email-wens@csie.org>
References: <1428638946-24890-1-git-send-email-wens@csie.org>
 <1428638946-24890-5-git-send-email-wens@csie.org>
Message-ID: <20150410154809.GN6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 12:09:04PM +0800, Chen-Yu Tsai wrote:

> This patch depends on the previous patch "regulator: axp20x: prepare
> support for multiple AXP chip families" and the mfd header from the
> first patch "mfd: axp20x: add AXP22x PMIC support".

> Could we merge both regulator patches through the mfd tree, with the
> other patches in the series? There are no other external dependencies.

Yes, of course we can - that's the whole point of me sending a
Reviewed-by!  Half of what I'm trying to do with that is to cut down on
the number of reposts of MFD series I get sent :(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150410/87044ca6/attachment.sig>
