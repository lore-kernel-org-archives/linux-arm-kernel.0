From: ospite@studenti.unina.it (Antonio Ospite)
Date: Mon, 26 Oct 2009 20:22:57 +0100
Subject: [WARNING] pxamci: 'pxa2xx-mci.0' does not have a release()
	function.
In-Reply-To: <20091026184815.GA16735@sirena.org.uk>
References: <20091023003631.1331a60a.ospite@studenti.unina.it>
	<20091022225758.GA9106@n2100.arm.linux.org.uk>
	<20091023115028.59ed7f74.ospite@studenti.unina.it>
	<20091023101806.GB19437@n2100.arm.linux.org.uk>
	<20091026165852.GC18218@kroah.com>
	<20091026184815.GA16735@sirena.org.uk>
Message-ID: <20091026202257.d82b8d97.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Oct 2009 18:48:15 +0000
Mark Brown <broonie@sirena.org.uk> wrote:

> > > On Fri, Oct 23, 2009 at 11:50:28AM +0200, Antonio Ospite wrote:
> 
> > > > A little more background: we need pxamci to be a child of SPI because
> > > > our PMIC is connected via SPI, and a PMIC regulator is used for mmc
> > > > powering; enforcing this hierarchy is needed to make pxamci suspend and
> > > > resume properly.
> 
...
> I believe that the pm_link stuff in -next is what's needed here?  I was
> planning to look at this within the regulator API before the next merge
> window so that I can hopefully have something ready for -next after that
> (or possibly even get it in in the same merge window if the cross tree
> issues aren't too painful).

Ah, good to know that there is a proper solution coming.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091026/8e5d9046/attachment.sig>
