From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 Jan 2014 20:13:19 +0100
Subject: Issue with the emulated PCI bridge implementation
In-Reply-To: <20140103201024.08ca11fb@skate>
References: <20131226160534.36cc4203@skate> <3246739.aRbALcNl1Y@wuerfel>
 <20140103201024.08ca11fb@skate>
Message-ID: <12006165.Jkey40UWy0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 January 2014 20:10:24 Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Fri, 03 Jan 2014 20:04:57 +0100, Arnd Bergmann wrote:
> 
> > > Digging in the LAKML archive, I found a lspci -v output about the
> > > e1000e, and it has an I/O space:
> > 
> > Ok, thanks for the confirmation!
> > 
> > Do you mind posting your hack here? It may be useful for others as
> > well, such as the xgene developers that seem to be doing funny things
> > with their I/O space.
> 
> The current hack is the following very ugly piece of code... It runs
> some command and reads back some registers, and you should see some
> well-known values (which can be found in the e1000 datasheet, I don't
> remember them right now).

Totally enough for the purpose, thanks!

	Arnd
