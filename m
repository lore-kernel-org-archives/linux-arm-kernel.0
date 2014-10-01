From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 Oct 2014 14:59:58 +0100
Subject: [PATCH 18/24] ARM64: Add vdso for ILP32 and use it for the
 signal return
In-Reply-To: <1409779158-30963-19-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
 <1409779158-30963-19-git-send-email-apinski@cavium.com>
Message-ID: <20141001135957.GM12702@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 10:19:12PM +0100, Andrew Pinski wrote:
> This patch adds the VDSO for ILP32. We need to use a different
> VDSO than LP64 since ILP32 uses ELF32 while LP64 uses ELF64.
> 
> After this patch, signal handling works mostly.  In that signals
> go through their action and then returned correctly.

As you say "mostly", is there anything that does not work?

-- 
Catalin
