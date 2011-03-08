From: dilinger@queued.net (Andres Salomon)
Date: Tue, 8 Mar 2011 05:32:26 +0000
Subject: [PATCH] ARM: mx51_efika: update platform data for new mfd changes
In-Reply-To: <20110307144700.GF1829@sirena.org.uk>
References: <20110304080653.3f2c3f19@debxo> <4D710FF9.6040305@ru.mvista.com>
	<20110304083822.0f40d120@debxo> <4D713670.70506@ru.mvista.com>
	<20110307144700.GF1829@sirena.org.uk>
Message-ID: <20110308053226.7300e65d@debxo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Mar 2011 14:47:00 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Mar 04, 2011 at 09:58:56PM +0300, Sergei Shtylyov wrote:
> > Andres Salomon wrote:
> 
> >>>> MFD changes in c738892f cause the mc13xxx_platform_data struct
> 
> >>>     Linus asks to also specify the commit summary in parens.
> 
> >> Also, what?  If there are changes to how patches should be
> >> submitted, please provide a reference
> >> (Documentation/SubmittingPatches should be updated, as well).
> 
> >    I have no time to rummage in the mail archives, sorry.
> 
> There's been multiple discussions of this.  The issue is that commit
> IDs only mean something in specific trees and go bad if someone
> rebases, and they aren't legibile by humans (so even if the commit is
> in something like Linus' tree the reader still needs a git repository
> to figure out what changes are being talked about).

Ah, thanks, that makes sense.  Sergei's original statement was unclear
("...instead of just the commit ID" would've helped).
