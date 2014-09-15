From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Sep 2014 17:26:25 +0100
Subject: [PATCH] arm64: LLVMLinux: Fix inline arm64 assembly for use with
 clang
In-Reply-To: <20140915160240.GC29744@arm.com>
References: <20140909101515.GB1754@arm.com>
 <1410759015-15642-1-git-send-email-behanw@converseincode.com>
 <20140915160240.GC29744@arm.com>
Message-ID: <20140915162624.GH5415@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 05:02:41PM +0100, Will Deacon wrote:
> On Mon, Sep 15, 2014 at 06:30:15AM +0100, behanw at converseincode.com wrote:
> > From: Mark Charlebois <charlebm@gmail.com>
> > 
> > Remove '#' from immediate parameter in AARCH64 inline assembly in mmu.
> > 
> > This code now works with both gcc and clang.
> > 
> > Signed-off-by: Mark Charlebois <charlebm@gmail.com>
> > Signed-off-by: Behan Webster <behanw@converseincode.com>
> > ---
> >  arch/arm64/mm/mmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks, Behan!
> 
> Catalin: please can you pick this up for 3.18? It's probably not worth me
> merging it as a fix, since there are other patches needed to get us building
> under clang anyway.

I agree, it will go in for 3.18 rather than 3.17.

-- 
Catalin
