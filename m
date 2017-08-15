From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 15 Aug 2017 13:59:46 +0200
Subject: next-20170815 build: 2 failures 4 warnings (next-20170815)
In-Reply-To: <20170815111612.esq73hxowbw2mehj@sirena.org.uk>
References: <E1dhZPk-0002d9-9k@optimist>
 <20170815111612.esq73hxowbw2mehj@sirena.org.uk>
Message-ID: <13442814.gWUDHvzIl2@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 15, 2017 1:16:12 PM CEST Mark Brown wrote:
> 
> --xqegarazqzvkdxmo
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Tue, Aug 15, 2017 at 11:49:36AM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build on arm64 due to:
> 
> > 	arm64-allmodconfig
> > 	arm64-defconfig
> > ../drivers/acpi/spcr.c:168:1: error: expected expression before '<<' token
> > ../drivers/acpi/spcr.c:198:1: error: expected expression before '>>' token
> 
> caused by f69ba1326ac33b (Merge branch 'acpi-spcr' into linux-next)
> which has an unresolved conflict in it.

Yes, I broke this, sorry.

Will fix it shortly.

Thanks,
Rafael
