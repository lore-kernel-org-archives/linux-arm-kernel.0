From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Jun 2016 18:18:15 +0100
Subject: [PATCH 1/2] arm64: mm: dump: make page table dumping reusable
In-Reply-To: <1464702542-24394-2-git-send-email-mark.rutland@arm.com>
References: <1464702542-24394-1-git-send-email-mark.rutland@arm.com>
 <1464702542-24394-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20160617171815.GC24589@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 02:49:01PM +0100, Mark Rutland wrote:
> For debugging purposes, it would be nice if we could export page tables
> other than the swapper_pg_dir to userspace. To enable this, this patch
> refactors the arm64 page table dumping code such that multiple tables
> may be registered with the framework, and exported under debugfs.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Laura Abbott <labbott@fedoraproject.org>
> Cc: Will Deacon <will.deacon@arm.com>

Queued for 4.8. Thanks.

-- 
Catalin
