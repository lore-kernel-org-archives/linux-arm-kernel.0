From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Oct 2018 12:50:49 +0100
Subject: [PATCH v2] Documentation/arm64: HugeTLB page implementation
In-Reply-To: <87ftxf7812.fsf@e105922-lin.cambridge.arm.com>
References: <97e4e5fb-24ed-0545-414a-6a0c0116e6b8@infradead.org>
 <20181008100355.31820-1-punit.agrawal@arm.com>
 <67f4ceb7-d41c-ab7a-4d5e-c147dadf6860@infradead.org>
 <87ftxf7812.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20181009115049.GA6248@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2018 at 11:02:01AM +0100, Punit Agrawal wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
> > On 10/8/18 3:03 AM, Punit Agrawal wrote:
> >> Arm v8 architecture supports multiple page sizes - 4k, 16k and
> >> 64k. Based on the active page size, the Linux port supports
> >> corresponding hugepage sizes at PMD and PUD(4k only) levels.
> >> 
> >> In addition, the architecture also supports caching larger sized
> >> ranges (composed of multiple entries) at the PTE and PMD level in the
> >> TLBs using the contiguous bit. The Linux port makes use of this
> >> architectural support to enable additional hugepage sizes.
> >> 
> >> Describe the two different types of hugepages supported by the arm64
> >> kernel and the hugepage sizes enabled by each.
> >> 
> >> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks!
> 
> Catalin, Will - I assume you'll pick this up at some point? Or do arm64
> documentation patches get routed by another tree?

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin can pick this up for 4.20.

Will
