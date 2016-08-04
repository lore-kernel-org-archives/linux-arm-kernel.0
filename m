From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 4 Aug 2016 13:51:05 +0900
Subject: [PATCH v2 4/4] arm64: Add support for binary image files
In-Reply-To: <20160729171552.GB478@localhost.localdomain>
References: <cover.1469559530.git.geoff@infradead.org>
 <f352dcfc827a4cbb3878dd1043877a4154b1bd08.1469559530.git.geoff@infradead.org>
 <20160728040125.GA27150@localhost.localdomain>
 <1469729083.16559.26.camel@infradead.org>
 <20160729033514.GC27150@localhost.localdomain>
 <1469811760.16559.33.camel@infradead.org>
 <20160729171552.GB478@localhost.localdomain>
Message-ID: <20160804045104.GJ7995@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pratyush,

On Fri, Jul 29, 2016 at 10:45:52PM +0530, Pratyush Anand wrote:
> Hi Geoff,
> 
> On 29/07/2016:10:02:40 AM, Geoff Levand wrote:
> > On Fri, 2016-07-29 at 09:05 +0530, Pratyush Anand wrote:
> > 
> > > See kexec/crashdump-elf.c:FUNC()
> > > We have:
> > > 223                 phdr->p_vaddr = phys_to_virt(elf_info, mstart);
> > > 
> > 
> > These patches don't support kdump.
> 
> OK, so you suggest that I should keep this patch as it is and add --page-offset
> in corresponding kdump patch. I can do that, no issue.

I will add necessary hunks from your old patch when I submit
a next version of patches for arm64, probably next Monday.

I hope that you don't mind.

Thanks,
-Takahiro AKASHI

> ~Pratyush
