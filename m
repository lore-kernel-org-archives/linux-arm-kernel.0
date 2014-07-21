From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Jul 2014 16:44:42 +0100
Subject: [PATCH] spi: omap2-mcspi: fix blatant abuse of the resource
 subsystem
In-Reply-To: <20140721144104.5e37f1a0@ipc1.ka-ro>
References: <1405683053-14104-1-git-send-email-LW@KARO-electronics.de>
 <20140718171035.GQ17528@sirena.org.uk>
 <20140721075144.251bb67d@ipc1.ka-ro>
 <20140721121820.GW17528@sirena.org.uk>
 <20140721144104.5e37f1a0@ipc1.ka-ro>
Message-ID: <20140721154442.GB17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 02:41:04PM +0200, Lothar Wa?mann wrote:
> Mark Brown wrote:

> > Just to be clear the issue is with the presentation of your change, it
> > is not appropriate to provide a changelog which consists mainly of
> > widely directed personal insults especially given that it omits basic
> > technical content.

> I understood that, but I feel incapable to come up with a reasonable
> changelog for this.

Just describe in a specific, technical fashion what the problem is and
what the fix does without reference to personal qualities of the various
parties involved in the code being the way it is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140721/585a0d12/attachment.sig>
