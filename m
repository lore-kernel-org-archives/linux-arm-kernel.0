From: toshi.kani@hpe.com (Kani, Toshi)
Date: Thu, 17 May 2018 14:32:01 +0000
Subject: [PATCH v3 2/3] ioremap: Update pgtable free interfaces with addr
In-Reply-To: <20180517064755.GP12670@dhcp22.suse.cz>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
 <20180516233207.1580-3-toshi.kani@hpe.com>
 <20180517064755.GP12670@dhcp22.suse.cz>
Message-ID: <1526567449.2693.608.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-05-17 at 08:47 +0200, Michal Hocko wrote:
> On Wed 16-05-18 17:32:06, Kani Toshimitsu wrote:
> > From: Chintan Pandya <cpandya@codeaurora.org>
> > 
> > This patch ("mm/vmalloc: Add interfaces to free unmapped
> > page table") adds following 2 interfaces to free the page
> > table in case we implement huge mapping.
> > 
> > pud_free_pmd_page() and pmd_free_pte_page()
> > 
> > Some architectures (like arm64) needs to do proper TLB
> > maintanance after updating pagetable entry even in map.
> > Why ? Read this,
> > https://patchwork.kernel.org/patch/10134581/
> 
> Please add that information to the changelog.

I will update the description and resend this patch.

Thanks!
-Toshi
