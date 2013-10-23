From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 23 Oct 2013 13:55:24 -0400 (EDT)
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023171620.GA5208@netboy>
References: <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef> <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy> <20131023094903.GD11954@ulmo.nvidia.com>
 <20131023171620.GA5208@netboy>
Message-ID: <alpine.LFD.2.03.1310231355160.1951@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Oct 2013, Richard Cochran wrote:

> A kconfig option to allow unstable bindings seems okay to me in
> principle, as long as progress toward getting stable bindings
> continues. However, I expect that this option would become a "sticky
> bit" that is just left on forever (remember CONFIG_EXPERIMENTAL?).
> There would be little motivation for developers to ever get bindings
> into the "stable" category.

Such config option is therefore pointless.

> I still don't understand why someone (linario?) can't host an
> arm-dt-devel tree that allows the freedom to change bindings and
> features the best source for supporting the latest ARM SoCs. I don't
> buy the argument that only Linus' tree gets enough testing. If another
> tree really is the best ARM tree, then it will get plenty of attention
> and testing.

So you're basically saying that we should split the development effort 
across multiple trees instead of encouraging people to converge on the 
same tree?  This is completely contrary to all the efforts we've been 
deploying to encourage people to submit their code upstream.

ii> As an end user, I don't mind waiting for a feature if that means
> stability and QA. If I get impatient, still I always have the choice
> to take a development version. But I do not want to be forced to take
> unfinished work in a released kernel.

If as an end user you want full QA, you should go with a distro kernel.

We're talking about the upstream kernel here, and given the current 
development and release rate we hardly can guarantee you that it'll be 
free of unfinished work (as long as it doesn't regress existing 
features).


Nicolas
