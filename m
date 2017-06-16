From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Jun 2017 10:18:56 +0100
Subject: Applied "ASoC: rockchip: Fix an error handling in
 'rockchip_i2s_probe'" to the asoc tree
In-Reply-To: <e92fef8d-5ce1-0b7d-d130-0246d2cb7f91@wanadoo.fr>
References: <20170615055311.8049-1-christophe.jaillet@wanadoo.fr>
 <E1dLYRz-0001l4-SZ@debutante>
 <e92fef8d-5ce1-0b7d-d130-0246d2cb7f91@wanadoo.fr>
Message-ID: <20170616091856.jz5d4trm5jz2ugan@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 06:57:30AM +0200, Christophe JAILLET wrote:
> Le 15/06/2017 ? 19:20, Mark Brown a ?crit :

> >   	if (!of_property_read_u32(node, "rockchip,playback-channels", &val)) {
> >   		if (val >= 2 && val <= 8)
> >   			soc_dai->playback.channels_max = val;

> ... and 'err' should be 'ret'...

> I'm really confused for such a ugly proposal !

In a situation like this it's generally best to send a patch, I'll fix
though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170616/09fc6b51/attachment.sig>
