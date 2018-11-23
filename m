From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Nov 2018 14:42:26 +0000
Subject: [PATCH V3 4/5] arm64/mm: Enable HugeTLB migration
In-Reply-To: <1540299721-26484-5-git-send-email-anshuman.khandual@arm.com>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-5-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20181123144226.GD3360@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 06:32:00PM +0530, Anshuman Khandual wrote:
> Let arm64 subscribe to generic HugeTLB page migration framework. Right now
> this only works on the following PMD and PUD level HugeTLB page sizes with
> various kernel base page size combinations.
> 
>        CONT PTE    PMD    CONT PMD    PUD
>        --------    ---    --------    ---
> 4K:         NA     2M         NA      1G
> 16K:        NA    32M         NA
> 64K:        NA   512M         NA
> 
> Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
