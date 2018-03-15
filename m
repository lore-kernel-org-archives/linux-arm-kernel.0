From: toshi.kani@hpe.com (Kani, Toshi)
Date: Thu, 15 Mar 2018 14:27:10 +0000
Subject: [PATCH v2 1/2] mm/vmalloc: Add interfaces to free unmapped page
 table
In-Reply-To: <20180314153835.68e75da3fdc18b27ad0e290c@linux-foundation.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-2-toshi.kani@hpe.com>
 <20180314153835.68e75da3fdc18b27ad0e290c@linux-foundation.org>
Message-ID: <1521124026.2693.141.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-03-14 at 15:38 -0700, Andrew Morton wrote:
> On Wed, 14 Mar 2018 12:01:54 -0600 Toshi Kani <toshi.kani@hpe.com> wrote:
 :
> 
> whoops.
> 
> --- a/include/asm-generic/pgtable.h~mm-vmalloc-add-interfaces-to-free-unmapped-page-table-fix
> +++ a/include/asm-generic/pgtable.h
> @@ -1014,7 +1014,7 @@ static inline int pud_free_pmd_page(pud_
>  {
>  	return 0;
>  }
> -static inline int pmd_free_pte_page(pud_t *pmd)
> +static inline int pmd_free_pte_page(pmd_t *pmd)
>  {
>  	return 0;
>  }

Thanks Andrew for catching this!!
-Toshi
