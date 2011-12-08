From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Dec 2011 18:08:28 +0000
Subject: [GIT PULL v3] Linux support for ARM LPAE
In-Reply-To: <20111208180536.GK14542@n2100.arm.linux.org.uk>
References: <20111208110349.GA26970@arm.com>
 <20111208180536.GK14542@n2100.arm.linux.org.uk>
Message-ID: <20111208180828.GE27757@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 06:05:36PM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 08, 2011 at 11:03:49AM +0000, Catalin Marinas wrote:
> > The series is rebased against Will's idmap series as merged in your
> > devel-stable tree (I couldn't fetch devel-stable this morning). Please
> > note that the branch was changed to 'for-rmk' (previously 'for-next').
> > The nopud fixup was already reordered so that it comes before your
> > patch.
> 
> Thank you.
> 
> Now pulled and merged - with the expected conflict in ioremap.c between
> your commits and 576d2f25 resolved.
> 
> I'll push it out shortly, so it should land in linux-next this evening.

Great! Thanks.

-- 
Catalin
