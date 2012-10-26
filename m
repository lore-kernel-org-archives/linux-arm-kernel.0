From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Oct 2012 17:00:51 +0000
Subject: [GIT PULL] vexpress: soc changes for v3.8
In-Reply-To: <1351270481.9454.34.camel@hornet>
References: <1350579917.4984.19.camel@hornet>
 <201210261645.00157.arnd@arndb.de> <1351270481.9454.34.camel@hornet>
Message-ID: <201210261700.52195.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 October 2012, Pawel Moll wrote:
> On Fri, 2012-10-26 at 17:44 +0100, Arnd Bergmann wrote:
> > On Thursday 18 October 2012, Pawel Moll wrote:
> > >       ARM: vexpress: Start using new Versatile Express infrastructure
> > 
> > This patch introduces calls to vexpress_clk_of_init and other functions
> > that don't yet exist. Can you send a fixup?
> 
> The clocking stuff should already be in the -next - Mike pulled it over
> two weeks ago. In any case the branch is here:

Right, it works in -next. Can you rebase the soc changes on top of the
stuff that went into Mike's tree and resubmit so it also builds in
arm-soc?

	Arnd
