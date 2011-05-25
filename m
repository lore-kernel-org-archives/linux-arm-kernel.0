From: tony@atomide.com (Tony Lindgren)
Date: Wed, 25 May 2011 10:59:02 +0300
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <BANLkTi=xzrLhHTBynWf4huA9EusfaDwPbA@mail.gmail.com>
References: <201105181047.17309.arnd@arndb.de>
	<BANLkTi=xzrLhHTBynWf4huA9EusfaDwPbA@mail.gmail.com>
Message-ID: <20110525075902.GH30799@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [110518 17:49]:
> Arnd,
> 
> On 18 May 2011 09:47, Arnd Bergmann <arnd@arndb.de> wrote:
> > This is the draft plan for maintaining the ARM subarchitectures in a common
> > tree, as a way to help coordinate the upstream merging of the
> > arch/arm/{plat,mach}-* changes into Linus' tree.
> 
> For clarification - the aim of this subarchitecture group is not only
> to coordinate the upstream merging but also take an active (primary)
> role in consolidating the existing code across various
> subarchitectures under arch/arm/.

It's good to see organized effort on consolidating the code.
And Linaro is probably the best place to organize this effort.

Naturally I assume that you guys won't be merging any platform
specific patches without proper acks from the platform maintainers:

Acked-by: Tony Lindgren <tony@atomide.com>

Arnd, do you want to do a practise run with pulling in the omap
code and merging to Linus for this merge window?

Regards,

Tony
