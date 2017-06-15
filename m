From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Jun 2017 20:12:53 +0100
Subject: Applied "ASoC: rockchip: Fix an error handling in
 'rockchip_i2s_probe'" to the asoc tree
In-Reply-To: <77af69fd-3135-36d6-385b-82d044c32f44@wanadoo.fr>
References: <20170615055311.8049-1-christophe.jaillet@wanadoo.fr>
 <E1dLYRz-0001l4-SZ@debutante>
 <77af69fd-3135-36d6-385b-82d044c32f44@wanadoo.fr>
Message-ID: <20170615191253.ffuz3jay2fothn37@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 07:32:53PM +0200, Christophe JAILLET wrote:
> Le 15/06/2017 ? 19:20, Mark Brown a ?crit :

> > -	memcpy(soc_dai, &rockchip_i2s_dai, sizeof(*soc_dai));
> >   	if (!of_property_read_u32(node, "rockchip,playback-channels", &val)) {
> >   		if (val >= 2 && val <= 8)
> >   			soc_dai->playback.channels_max = val;

> Thanks for taking the patch, but there is a typo in it. A comma is missing
> as spotted by the kbuild test robot.

> I hope that you have seen it and fixed it before applying.

Ugh, no.  Like the mail says this is the patch that got applied.  The
kbuild tests were against the rockchip tree not mine so i thought this
was something else...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170615/a4b58d5b/attachment.sig>
