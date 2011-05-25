From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 May 2011 10:23:44 +0200
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <201105181047.17309.arnd@arndb.de>
References: <201105181047.17309.arnd@arndb.de>
Message-ID: <20110525082344.GF22096@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2011 at 10:47:16AM +0200, Arnd Bergmann wrote:
> This is the draft plan for maintaining the ARM subarchitectures in a common
> tree, as a way to help coordinate the upstream merging of the
> arch/arm/{plat,mach}-* changes into Linus' tree.
> 
> This was discussed in great length at the Linaro Developer Summit in Budapest
> last week where we worked out an initial plan. We are modeling the maintainance
> after how the linux-tip tree is used for the x86 architecture, with a set
> of developers that have commit access to one tree on kernel.org and
> have mutual trust in one another. Nicolas Pitre and me are funded
> by Linaro to do the bulk of the work, while Thomas Gleixner will help
> us part-time with his long time architecture maintainance experience.
> Despite the funding by Linaro, this is not a Linaro project and all
> ARM subarchitectures are welcome to go through our tree.
> 
> Russell King's role as ARM maintainer is of course unchanged by this, but
> he has the same commit access to the new tree as the other maintainers and
> is welcome to work in the same tree. We are also open to nominations for
> further people outside of Linaro to join us as committers. Marc Zyngier from
> ARM ltd is one of the candidates that has been suggested and I would also
> like to see someone from Google. We have to find the right balance with the
> number of committers so we get all the work done without stepping on each
> other's toes.
> 
> Our tree will be strictly organized in topic brances so we can feed them
> upstream in the bitesized chunks that Linus likes. The master branch
> is an integration branch that pulls all other branches that are scheduled
> for the next merge window and itself gets integrated into linux-next.
> 
> We will probably not be fully functional during the 2.6.40 merge window,
> but we are trying our best to be useful. For 2.6.41, my hope is that
> we can merge the bulk of the ARM subarchitecture changes through this
> tree. Once Linus is happy with the way that the process works, we can
> mandate that all ARM subarchitecture changes go through our tree, until
> then it stays voluntary.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> 
> ---
> 
> Maintainers: If you are happy with the layout of the process,
> please ack this patch, otherwise please comment.

As Freescale i.MX maintainer:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
