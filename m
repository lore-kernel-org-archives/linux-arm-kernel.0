From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 18 May 2011 17:56:15 +0200
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <201105181047.17309.arnd@arndb.de>
References: <201105181047.17309.arnd@arndb.de>
Message-ID: <20110518155615.GJ15292@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:47 Wed 18 May     , Arnd Bergmann wrote:
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
How do you plan to manage with already sub arch maintainers?

In my ming such tree could be good to organise cross arch drivers
but for real arch specific the current workflow is good

If we add a new stage it will be difficult to follow for people

I'd like to have scenario example where such workflow will give a significant
advantage compare to the current workflow. And please real example.

Best Regards,
J.
