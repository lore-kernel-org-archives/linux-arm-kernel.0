From: ben@trinity.fluff.org (Ben Dooks)
Date: Tue, 28 Jun 2011 22:23:12 +0100
Subject: [PATCH] ARM: mach-s3c24a0: delete
In-Reply-To: <201106282312.28285.arnd@arndb.de>
References: <alpine.LFD.2.00.1106281613380.2142@xanadu.home>
	<201106282312.28285.arnd@arndb.de>
Message-ID: <20110628212312.GG21138@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 11:12:28PM +0200, Arnd Bergmann wrote:
> On Tuesday 28 June 2011 22:17:30 Nicolas Pitre wrote:
> > Commit bcae8aeb32 "[ARM] S3C24A0: Initial architecture support files"
> > brought in a bunch of files while explicitly leaving out the corresponding
> > Kconfig entry, stating that the series is not complete.
> > 
> > More than 2.5 years later, the support for this has not seen any progress.
> > This is therefore dead code.  If someone wants to revive this code, it is
> > always possible to retrieve it from the Git repository.
> > 
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> Good catch!
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Do you want to submit that into a new branch for removing obsolete stuff?

Probably easy enough to submit for -rc ?

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
