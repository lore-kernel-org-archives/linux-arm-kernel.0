From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 May 2011 22:27:59 +0200
Subject: [RESEND PATCH 2/4] omap: igep0020: minor refactoring
In-Reply-To: <20110515185043.GA24785@gentoodev.compulab.local>
References: <cover.1305235542.git.mike@compulab.co.il>
	<201105132044.39163.arnd@arndb.de>
	<20110515185043.GA24785@gentoodev.compulab.local>
Message-ID: <201105152228.00408.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 May 2011, mike at compulab.co.il wrote:
> We can keep all the data structures that differ between IGEP2 and IGEP3.
> However, this significantly reduces the benifit of the series.
> There's already code in the IGEP2 that differentiates between HW
> revisions, so anyway the board support will require some work for
> devicetree transition. Eventually, when devicetree will be usable on
> OMAPs, most of the code currently found in arch/arm/mach-omap2/board*
> will require some work and I hardly believe that the transition can be
> automated...

True. Let's just use the version you posted then.

	Arnd
