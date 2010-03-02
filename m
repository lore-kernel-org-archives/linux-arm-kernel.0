From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 2 Mar 2010 11:33:53 +1100
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <20100301102727.GC16049@pengutronix.de>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
	<20100225205113.GF3101@n2100.arm.linux.org.uk>
	<20100225212915.GA24043@n2100.arm.linux.org.uk>
	<f17812d71002260105q54c26198jc9b61851c35ae8ef@mail.gmail.com>
	<20100228161449.GD16745@n2100.arm.linux.org.uk>
	<20100301093927.GC29952@pengutronix.de>
	<20100301094820.GA10863@n2100.arm.linux.org.uk>
	<20100301101140.GA12088@linux-sh.org>
	<20100301102727.GC16049@pengutronix.de>
Message-ID: <20100302113353.889ea646.sfr@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, 1 Mar 2010 11:27:27 +0100 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
>
> > Out of the non-PXA merge requests, the only conflicts seem to be on
> > Kconfig/Makefile bits as usual, being fairly insular beyond that. While
> > these are fairly easy to sort out,
> Only a nice hint to whoever will merge the different arm trees in the
> end: Note that next is (or recently was) broken, because git merged two
> arm trees successfully (i.e. didn't result in a conflict) according to
> Stephen and broke arch/arm/Kconfig with it.  See
> 
> 	http://thread.gmane.org/gmane.linux.ports.arm.kernel/75250
> 
> for the exact details.
> 
> (I don't know if Stephen reports these issues to Linus anyhow, so this
> mail might have been sent for nothing.)

Thanks for that, I had not pointed that one out to Linus, yet.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100302/82ccbada/attachment.sig>
