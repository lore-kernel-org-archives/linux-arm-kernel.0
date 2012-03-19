From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Mar 2012 08:57:23 +0000
Subject: ARM: fix build failure on ux500 in linux-next
In-Reply-To: <CACRpkdYzS=wkfUU4gJLTp7djd6J20zVCC_6XhrjwoVpAoSe8iA@mail.gmail.com>
References: <20120316211759.GA18829@windriver.com>
 <CACRpkdYzS=wkfUU4gJLTp7djd6J20zVCC_6XhrjwoVpAoSe8iA@mail.gmail.com>
Message-ID: <201203190857.23489.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 18 March 2012, Linus Walleij wrote:
> On Fri, Mar 16, 2012 at 10:18 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> 
> > When I 1st saw this build failure, I thought it was me, because of the
> > BUG() stuff.  But git bisect claims it comes from the arm-soc tree?
> 
> Hm yeah looks like that, but we cannot see which commit
> I guess, just that it's the merge from ARM SoC?
> 
> > In any case, the fix is trivial and self evident, regardless of where
> > it came from.  I can carry it in my bug-3.4 cleanup tree if need be.
> > Let me know if you want me to do that.
> 
> Any way that solves the issue is fine with me, maybe Arnd/Olof
> wants to apply it to the ARM SoC tree rather? If they don't say
> anything, by all means please keep it in cleanup.

As Lee commented, it should be fixed already with Marc's fixup patch.
Paul, if you still see it in some configuration on the today's linux-next,
please let us know.

	Arnd
