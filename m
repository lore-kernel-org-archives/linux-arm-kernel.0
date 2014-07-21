From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Jul 2014 13:18:20 +0100
Subject: [PATCH] spi: omap2-mcspi: fix blatant abuse of the resource
 subsystem
In-Reply-To: <20140721075144.251bb67d@ipc1.ka-ro>
References: <1405683053-14104-1-git-send-email-LW@KARO-electronics.de>
 <20140718171035.GQ17528@sirena.org.uk>
 <20140721075144.251bb67d@ipc1.ka-ro>
Message-ID: <20140721121820.GW17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 07:51:44AM +0200, Lothar Wa?mann wrote:
> Mark Brown wrote:

> > I'm not going to apply this with a commit message such as the above.
> > Quite aside from the tone the fact that it doesn't describe the issue
> > is not helpful for review, one of the things done in review is to try to
> > check that the change has the intended effect.

> Maybe the original author or the maintainer who accepted this can come
> up with a decent fix for this.

Just to be clear the issue is with the presentation of your change, it
is not appropriate to provide a changelog which consists mainly of
widely directed personal insults especially given that it omits basic
technical content.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140721/60630cbb/attachment.sig>
