From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Sep 2013 16:14:50 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <522D3B79.3060707@freescale.com>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
Message-ID: <20130909151450.GI29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 09, 2013 at 11:07:37AM +0800, Huang Shijie wrote:
> ? 2013?09?08? 21:47, Mark Brown ??:

> > So the abstraction could say what the commands are, or what's supported

> I have already added the comment for what the commands are, please see
> patch 3 & patch 4.

> > if they're standard?

> In actually, there is no standard for the SPI NOR commands now.

> I added these commands just in the Spansion section now.
> (Of course, other NOR vendors may also uses the same commands.)

So then an abstraction which hides the details of which commands are
needed from the drivers seems sensible?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130909/907297e1/attachment-0001.sig>
