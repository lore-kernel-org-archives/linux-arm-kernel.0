From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Oct 2018 13:54:32 +0100
Subject: [PATCH 0/5] ARM64 MM Random Cleanups
In-Reply-To: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
References: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20181001125431.GC25071@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2018 at 09:09:51PM +0530, Anshuman Khandual wrote:
> This just contains some unrelated cleanup patches on memory.
> 
> Anshuman Khandual (5):
>   arm64/mm: Use ESR_ELx_FSC macro while decoding fault exception
>   arm64/mm: Reorganize arguments for is_el1_permission_fault()
>   arm64/mm: Define esr_to_debug_fault_info()
>   arm64/numa: Report correct memblock range for the dummy node
>   arm64/numa: Unify common error path in numa_init()

Queued for 4.20. Thanks.

-- 
Catalin
