From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Jul 2018 10:26:34 +0100
Subject: [PATCH v5 00/11] hugetlb: Factorize hugetlb architecture
 primitives
In-Reply-To: <20180731060155.16915-1-alex@ghiti.fr>
References: <20180731060155.16915-1-alex@ghiti.fr>
Message-ID: <20180731092634.m4wpbhyn54r7fxmb@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 06:01:44AM +0000, Alexandre Ghiti wrote:
> Alexandre Ghiti (11):
>   hugetlb: Harmonize hugetlb.h arch specific defines with pgtable.h
>   hugetlb: Introduce generic version of hugetlb_free_pgd_range
>   hugetlb: Introduce generic version of set_huge_pte_at
>   hugetlb: Introduce generic version of huge_ptep_get_and_clear
>   hugetlb: Introduce generic version of huge_ptep_clear_flush
>   hugetlb: Introduce generic version of huge_pte_none
>   hugetlb: Introduce generic version of huge_pte_wrprotect
>   hugetlb: Introduce generic version of prepare_hugepage_range
>   hugetlb: Introduce generic version of huge_ptep_set_wrprotect
>   hugetlb: Introduce generic version of huge_ptep_set_access_flags
>   hugetlb: Introduce generic version of huge_ptep_get
[...]
>  arch/arm64/include/asm/hugetlb.h             | 39 +++---------

For the arm64 bits in this series:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
