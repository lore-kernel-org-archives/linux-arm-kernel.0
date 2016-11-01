From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 1 Nov 2016 11:32:07 -0600
Subject: [GIT PULL] firmware: SCPI updates for v4.10
In-Reply-To: <20161029183951.GE4195@localhost>
References: <20161028112920.GB12241@e107155-lin>
 <20161029183951.GE4195@localhost>
Message-ID: <20161101173207.GA772@e106835-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2016 at 11:39:51AM -0700, Olof Johansson wrote:
> Hi Sudeep,
> 
> On Fri, Oct 28, 2016 at 12:29:20PM +0100, Sudeep Holla wrote:
> > Hi ARM-SoC Team,
> > 
> > Please pull !
> > 
> > --
> > Regards,
> > Sudeep
> > 
> > The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> > 
> >   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scpi-updates-4.10
> > 
> > for you to fetch changes up to a9e0192d8b35c6ab115a154ed1499ff39a0e5b06:
> > 
> >   firmware: arm_scpi: add support for legacy match table on Amlogic GXBB SoC (2016-10-19 15:17:28 +0100)
> > 
> > ----------------------------------------------------------------
> > SCPI updates for v4.10
> > 
> > 1. Adds support for Legacy SCPI(pre- SCPI v1.0) protocol
> > 
> > 2. Adds support for SCPI used on Amlogic GXBB SoC using the legacy
> >    SCPI protocol
> > 
> > ----------------------------------------------------------------
> > Neil Armstrong (5):
> >       dt-bindings: Add support for Amlogic GXBB SCPI Interface
> 
> I had comments on this patch, just emailed as follow-up to it.
>

Thanks for having a look, will address it.

> Also, you didn't sign off on it when applying it, seems like a mistake.
>

Ah, yes that was stupid mistake as I pulled that last minute.

> Please respin, ideally with the other changes also done (i.e. splitting off
> Juno stuff from arm,scpi.txt).
>

OK.

--
Regards,
Sudeep
