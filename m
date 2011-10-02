From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Oct 2011 16:47:16 +0100
Subject: [PATCH 00/11] Generic ARM fixes for randconfig
In-Reply-To: <1412110.pVL3lEeEnX@wuerfel>
References: <1317496920-7764-1-git-send-email-arnd@arndb.de>
	<20111002153646.GX11710@n2100.arm.linux.org.uk>
	<1412110.pVL3lEeEnX@wuerfel>
Message-ID: <20111002154716.GY11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 05:42:16PM +0200, Arnd Bergmann wrote:
> On Sunday 02 October 2011 16:36:46 Russell King - ARM Linux wrote:
> > On Sat, Oct 01, 2011 at 09:21:49PM +0200, Arnd Bergmann wrote:
> > > Please pull these into your tree, or alternatively cherry-pick the
> > > ones that you are happy with if you disagree with some of them.
> > 
> > I think I'll merge all but the first from this - I think the first
> > should be part of a cross-arch cleanup.
> 
> Ok, thanks!
> 
> I'll put the remaining patch into my 'randconfig/hacks' branch, which
> already contains a number of other things that need a proper fix but
> for which there is an easier circumvention.
> 
> Once all the low-hanging fruit are dealt with, I'll get back to that
> branch.

Second thought, I'll take the lot because it fixes build problems, and
the comment on patch 1 can be addressed later.
