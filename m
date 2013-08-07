From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Aug 2013 16:28:59 +0100
Subject: [PATCH V3 6/7] ASoC: Samsung: wm8994: Register the osc clock.
In-Reply-To: <1445367.zmBep3Ocuo@amdc1227>
References: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
 <1375866616-5541-7-git-send-email-padma.v@samsung.com>
 <1445367.zmBep3Ocuo@amdc1227>
Message-ID: <20130807152859.GD6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 05:18:10PM +0200, Tomasz Figa wrote:

> I don't think this patch is needed at all. You can use generic fixed rate 
> clock bindings[1] to define a fixed rate clock using device tree.

OK, good - that's what I'd have expected but I wasn't sure if that
hadn't been defined for some reason.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/aa6bdd88/attachment.sig>
