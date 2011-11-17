From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 10:49:48 +0000
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <20111117102623.GG4748@arm.com>
References: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
 <CAOesGMhWxEKUe7C4A+Xqv3RjN_u1t4k8eHWSZE4qMoBPD9=1qw@mail.gmail.com>
 <20111116235024.GH9581@n2100.arm.linux.org.uk>
 <CAOesGMgmVdck4rP9iQ+eBc+R1p-eVChnumiszB_D77Q0Rtyf3Q@mail.gmail.com>
 <20111117102623.GG4748@arm.com>
Message-ID: <20111117104948.GN9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 10:26:23AM +0000, Catalin Marinas wrote:
> I don't remember the details but couple of years ago someone working on
> Java in ARM pointed out that a cache operation spanning two vmas only
> flushes a single one. I think the JIT was modified since as I haven't
> heard back but I would be more in favour of just dropping the vma
> checks altogether.

To put this bluntly, if you still think that after my previous reply
to you, then you shouldn't be touching the kernel because you don't
understand the effects of the changes you're proposing - and that's
already making the allowance that you should _already_ had thought
about the security aspects of what you were suggesting _before_ posting
such a buggered suggestion.
