From: horms@verge.net.au (Simon Horman)
Date: Fri, 15 Jul 2016 13:29:53 +0900
Subject: [GIT PULL v2] Second Round of Renesas ARM64 Based SoC DT Updates
 for v4.8
In-Reply-To: <8207439.0JmbbpvM5T@wuerfel>
References: <cover.1467900241.git.horms+renesas@verge.net.au>
 <8207439.0JmbbpvM5T@wuerfel>
Message-ID: <20160715042952.GF28151@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 05:54:25PM +0200, Arnd Bergmann wrote:
> On Thursday, July 7, 2016 4:39:45 PM CEST Simon Horman wrote:
> >       arm64: dts: r8a7796: Add SYSC PM Domains
> > 
> 
> While doing some sanity checks on our branch contents, I noticed
> that this commit breaks running "make dtbs" on top of our next/dt64
> branch, and I'd like to avoid that.
> 
> I found a couple more problems (tegra and meson), and I ended up
> fixing them all up (by merging the dependencies into next/dt64),
> so everything is sorted for 4.8, but it would be good to do a
> 'make dtbs' run on a branch that has dt changes before you send it,
> and I'll try to do the same when pulling it to avoid the problem in
> the future.

Thanks, I apologise for letting this slip through.
