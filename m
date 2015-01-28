From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 17:29:07 +0100
Subject: [PATCH] Smack: fix netfilter Makefile entry
In-Reply-To: <54C90DE8.1030600@schaufler-ca.com>
References: <2504358.ZeqdfUXKpJ@wuerfel> <54C90DE8.1030600@schaufler-ca.com>
Message-ID: <1767230.5ujIMaZVYc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 January 2015 08:27:20 Casey Schaufler wrote:
> On 1/28/2015 8:12 AM, Arnd Bergmann wrote:
> > The newly added Smack support for netfilter secmark has its own
> > Kconfig symbol, but the actual implementation is conditionally
> > built on another symbol.
> 
> A patch for this problem, 82b0b2c2b1e64ad6c5309a9eeba806af9812666b
> is already available in:
> 
> 	git://git.gitorious.org/smack-next/kernel.git smack-for-3.20-rebased
> 
> A pull request has sent to James Morris for inclusion in the security tree.

Ok, thanks!

	Arnd
