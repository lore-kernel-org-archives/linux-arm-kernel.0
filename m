From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 May 2015 15:03:21 +0100
Subject: [PATCH 1/2] Regulator: mc34708: Add DT binding documentation
In-Reply-To: <1816610654.762513.1430483624334.JavaMail.open-xchange@oxbaltgw08.schlund.de>
References: <20150428141736.16243.57292.stgit@localhost>
 <20150428141738.16243.18377.stgit@localhost>
 <1345809430.776937.1430476461635.JavaMail.open-xchange@oxbaltgw07.schlund.de>
 <20150501110123.GU22845@sirena.org.uk>
 <1816610654.762513.1430483624334.JavaMail.open-xchange@oxbaltgw08.schlund.de>
Message-ID: <20150501140321.GZ22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 01, 2015 at 02:33:44PM +0200, Stefan Wahren wrote:
> > Mark Brown <broonie@kernel.org> hat am 1. Mai 2015 um 13:01 geschrieben:

> > On Fri, May 01, 2015 at 12:34:21PM +0200, Stefan Wahren wrote:

> > > a commit message would be nice and the subject should specify dt-bindings
> > > instead of regulator subsystem.

> > No, it shouldn't. DT bindings for a subsystem go through the subsystem
> > and the subsystem maintainer needs to see them to read them.

> sorry for my bad expressing. 

> I tought the subject line should be something like:

> DT: add binding documentation for mc34708 regulator

No, it shouldn't.  The subject line should start "regulator: " like all
other regulator commits.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150501/8ee4b2e6/attachment.sig>
