From: panand@redhat.com (Pratyush Anand)
Date: Fri, 29 Jul 2016 22:45:52 +0530
Subject: [PATCH v2 4/4] arm64: Add support for binary image files
In-Reply-To: <1469811760.16559.33.camel@infradead.org>
References: <cover.1469559530.git.geoff@infradead.org>
 <f352dcfc827a4cbb3878dd1043877a4154b1bd08.1469559530.git.geoff@infradead.org>
 <20160728040125.GA27150@localhost.localdomain>
 <1469729083.16559.26.camel@infradead.org>
 <20160729033514.GC27150@localhost.localdomain>
 <1469811760.16559.33.camel@infradead.org>
Message-ID: <20160729171552.GB478@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 29/07/2016:10:02:40 AM, Geoff Levand wrote:
> On Fri, 2016-07-29 at 09:05 +0530, Pratyush Anand wrote:
> 
> > See kexec/crashdump-elf.c:FUNC()
> > We have:
> > 223                 phdr->p_vaddr = phys_to_virt(elf_info, mstart);
> > 
> 
> These patches don't support kdump.

OK, so you suggest that I should keep this patch as it is and add --page-offset
in corresponding kdump patch. I can do that, no issue.

~Pratyush
