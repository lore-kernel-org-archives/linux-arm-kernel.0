From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Jun 2011 23:22:57 +0200
Subject: [PATCH] ARM: mach-s3c24a0: delete
In-Reply-To: <20110628211712.GF21138@trinity.fluff.org>
References: <alpine.LFD.2.00.1106281613380.2142@xanadu.home>
	<20110628211712.GF21138@trinity.fluff.org>
Message-ID: <201106282322.57631.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 June 2011 23:17:12 Ben Dooks wrote:
> On Tue, Jun 28, 2011 at 04:17:30PM -0400, Nicolas Pitre wrote:
> > 
> > Commit bcae8aeb32 "[ARM] S3C24A0: Initial architecture support files"
> > brought in a bunch of files while explicitly leaving out the corresponding
> > Kconfig entry, stating that the series is not complete.
> > 
> > More than 2.5 years later, the support for this has not seen any progress.
> > This is therefore dead code.  If someone wants to revive this code, it is
> > always possible to retrieve it from the Git repository.
> 
> Ok, there was never much interest in this getting merged and removing
> it is probably the best thing as I do not have the time to finish it
> off...
>  
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Acked-by: Ben Dooks <ben-linux@fluff.org>
> 

On a related note, what about mach-s3c2400? It seems to be even more
incomplete.

	Arnd
