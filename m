From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Feb 2015 15:15:42 +0000
Subject: [PATCH v6 0/7] PCI: get DMA configuration from parent device
In-Reply-To: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <20150206151542.GD23190@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 09:52:52PM +0000, Murali Karicheri wrote:
> This patch add an important capability to PCI driver on Keystone. I hope to
> have this merged to the upstream branch so that it is available for v3.20.

It's very late for 3.20 and the code hasn't been in linux-next at all
(but it's not me who's merging this code), unless you can squeeze it in
as a bug-fix.

But the good part is that there is more time to fix the dma mask setting
as well ;).

> PCI devices on Keystone doesn't have correct dma_pfn_offset set. This patch
> add capability to set the dma configuration such as dma-mask, dma_pfn_offset,
> and dma ops etc using the information from DT. The prior RFCs and discussions
> are available at [1] and [2] below.

For the series, you can add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
