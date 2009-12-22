From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2009 15:27:05 +0000
Subject: Remove redundant vma_vm_flags from v7wbi_flush_user_tlb_range
In-Reply-To: <4B2B7B8D.9030403@l4dev.org>
References: <4B2B7B8D.9030403@l4dev.org>
Message-ID: <20091222152705.GA17191@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 02:54:37PM +0200, Bahadir Balban wrote:
> Hi,
>
> You don't seem to be testing for VM_EXEC as in v6 version, so  
> vma_vm_flags seem redundant. What do you think?

With a properly signed off patch, it could go to the patch system.
