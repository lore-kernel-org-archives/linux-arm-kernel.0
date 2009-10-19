From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2009 16:54:22 +0100
Subject: [PATCH 3/4] Revert 75f4aa1 (unconditionally define
	__virt_to_phys and __phys_to_virt)
In-Reply-To: <1255967217.31096.43.camel@pc1117.cambridge.arm.com>
References: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
	<20091015122204.739.25384.stgit@pc1117.cambridge.arm.com>
	<20091019153441.GF13614@n2100.arm.linux.org.uk>
	<1255967217.31096.43.camel@pc1117.cambridge.arm.com>
Message-ID: <20091019155422.GH13614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2009 at 04:46:57PM +0100, Catalin Marinas wrote:
> On Mon, 2009-10-19 at 16:34 +0100, Russell King - ARM Linux wrote:
> > On Thu, Oct 15, 2009 at 01:22:04PM +0100, Catalin Marinas wrote:
> > > The SPARSEMEM support for RealView PBX requires non-linear physical to
> > > virtual address translation.
> > 
> > Since we have two platforms which are wanting this, I think this shouldn't
> > be a separate patch, but merely just a 'git revert' of the original.
> 
> Well, git revert just generates another commit with a different author
> and a reverted diff from the original commit. My patch just adds a
> different comment from the standard one.

I think it's sensible to keep at least the summary line of a 'git revert'
intact rather than inventing our own.

> Will you revert this commit in your tree? I don't know how to submit
> "git revert" commands to the patch system :-).

Done.
