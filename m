From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jan 2014 21:49:10 +0000
Subject: [PATCH v2 1/2] spi: spi-imx: enable dma support for escpi
 controller
In-Reply-To: <CAHrpEqS-_EBa2z+StMjk9upeyLWLff_p=bS+14TVMDQjoEHv+g@mail.gmail.com>
References: <1388789632-12238-1-git-send-email-Frank.Li@freescale.com>
 <CAHrpEqS-_EBa2z+StMjk9upeyLWLff_p=bS+14TVMDQjoEHv+g@mail.gmail.com>
Message-ID: <20140114214910.GC15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 04:56:02PM -0600, Frank Li wrote:

> > Signed-off-by: Frank Li <Frank.Li@freescale.com>

> ping!

Don't send contentless pings, either your mail has been lost (in which
case it'll need resending anyway) or this is just yet another mail to
read.  You should also, as covered in SubmittingPatches, CC any patches
to both the maintainers (remembering to use the address in MAINTAINERS)
and the relevant mailing list.  For SPI that's:

SPI SUBSYSTEM
M:      Mark Brown <broonie@kernel.org>
L:      linux-spi at vger.kernel.org
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
Q:      http://patchwork.kernel.org/project/spi-devel-general/list/
S:      Maintained
F:      Documentation/spi/
F:      drivers/spi/
F:      include/linux/spi/
F:      include/uapi/linux/spi/

It's OK to send to other places as well but don't rely on them, for
example my linux-arm-kernel folder currently has 1405 unread messages in
it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/0446376b/attachment.sig>
