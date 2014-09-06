From: broonie@kernel.org (Mark Brown)
Date: Sat, 6 Sep 2014 13:54:12 +0100
Subject: [PATCH] irq: gic-v3: Tag all low level accessors __maybey_unused
In-Reply-To: <20140817170453.GE12769@titan.lakedaemon.net>
References: <1406748194-21094-1-git-send-email-broonie@kernel.org>
 <20140817170453.GE12769@titan.lakedaemon.net>
Message-ID: <20140906125412.GA32429@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 01:04:53PM -0400, Jason Cooper wrote:
> On Wed, Jul 30, 2014 at 08:23:14PM +0100, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>

> > This is only really needed for gic_write_sgi1r in the !SMP case since it
> > is only referenced in the SMP initialisation code but it seems better to
> > have these functions all next to each other and declared consistently.

> > Signed-off-by: Mark Brown <broonie@linaro.org>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)

> Applied to irqchip/urgent

This appears to have disappeared from -next and the warning is back.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140906/2ede6ad0/attachment.sig>
