From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Jun 2014 16:41:35 +0200
Subject: Tegra 2 T20 NAND Flash Support
In-Reply-To: <538EC96A.4050702@ziswiler.com>
References: <538E6FB5.5020806@ziswiler.com> <1401866283.2173.3.camel@tellur>
 <538EC96A.4050702@ziswiler.com>
Message-ID: <20140604144134.GH28484@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 09:23:22AM +0200, Marcel Ziswiler wrote:
> On 06/04/2014 09:18 AM, Lucas Stach wrote:
> >I took the Linux Tegra NAND driver from Thierry and cleaned it up quite
> >a bit. It now works with both ONFI and non-ONFI NAND, at least for
> >reading. Writing doesn't quite work yet and I've got side-tracked with
> >other stuff.
> >
> >If you are interested in moving this forward I can put up my WIP patches
> >to some public location.
> 
> Sounds great, yes. That would be perfect, thanks.
> 
> We even once got an universal NAND test infrastructure from Micron based on
> a re-worked Colibri T20 which we could use to validate it with various NAND
> flash parts.

Excellent, I would've had a hard time digging up those patches. It's
really been quite a while.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/61b51825/attachment.sig>
