From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 12:49:41 +0000
Subject: [GIT PULL] U300 cleanups and sparseirq
In-Reply-To: <201208151243.40386.arnd@arndb.de>
References: <CACRpkdb6wB1QVNqn8_sHB8LH0To=aP_8+iocE8JZ2jKC5f_bYg@mail.gmail.com>
 <201208151243.40386.arnd@arndb.de>
Message-ID: <201208151249.42011.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 August 2012, Arnd Bergmann wrote:
> On Wednesday 15 August 2012, Linus Walleij wrote:
> > Hi ARM SoC maintainers,
> > 
> > could you please pull the following patch set sent out for review the other day
> > doing a number of cleanups and a minor improvement to U300, paving the
> > way for single zImage and device tree:
> > 
> > - Deprecate ancient platforms to make the following patches easier to
> >   make...
> > - Move out one header to platform data and one to the mach-u300 proper
> >   to depopulate <mach/*>
> > - Consolidate core machine files
> > - Convert to sparse IRQs
> 
> Pulled into next/soc.

On second thought, I've changed that and put it into next/cleanup instead.

	Arnd
