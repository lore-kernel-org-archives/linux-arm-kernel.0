From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 21:42:25 +0000
Subject: [PATCH v4 08/19] ARM: LPAE: Introduce the 3-level page table
	format definitions
In-Reply-To: <AANLkTi=d0q0Upde3=b4tpu3icOr4XdifcFRvBHuXgsBN@mail.gmail.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-9-git-send-email-catalin.marinas@arm.com>
	<AANLkTi=d0q0Upde3=b4tpu3icOr4XdifcFRvBHuXgsBN@mail.gmail.com>
Message-ID: <20110124214225.GO24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 08:26:42AM +1100, Nick Piggin wrote:
> Too bad about the PAE thing; my condolences.
> 
> 
> On Tue, Jan 25, 2011 at 4:55 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > This patch introduces the pgtable-3level*.h files with definitions
> > specific to the LPAE page table format (3 levels of page tables).
> 
> Seeing as you're shaking up these definitions, what do you think about
> switching from 4level-fixup.h to pgtable-nopud.h / pgtable-nopmd.h headers?
> One day eventually it would be nice to get rid of the fixup mode.

I have patches to do this which I de-queued for the last merge window.
It's not entirely trivial and without problem.  You can find the patches
in linux-next now.

I was waiting for the new set of patches from Catalin before going back
and working out the solutions to some of those problems.
