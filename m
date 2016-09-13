From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Sep 2016 17:53:55 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.9, take 2
In-Reply-To: <20160911204420.GA11949@lukather>
References: <20160911204420.GA11949@lukather>
Message-ID: <3492284.FjaSmsNYuk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, September 11, 2016 10:44:20 PM CEST Maxime Ripard wrote:
> Allwinner DT changes for 4.9, take 2
> 
> A second set of device tree changes, this time switching a few SoCs to the
> new sunxi-ng clock framework. We also added the support for a new SoC
> (NextThing GR8 and its evaluation board), and the support for the DRM
> driver in the A33.
> 
> 

Pulled into *next/late* because of the dependency, rather than next/dt.

I think this is better so we can send off the other next/dt changes
early on during the merge window without considering the dependency.

If the clk git gets sent before our pull requests, we might just
merge next/late back into next/dt.

Thanks,

	Arnd
