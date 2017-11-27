From: tj@kernel.org (Tejun Heo)
Date: Mon, 27 Nov 2017 11:50:21 -0800
Subject: [PATCH V3 04/29] ata: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511801886-6753-5-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-5-git-send-email-okaya@codeaurora.org>
Message-ID: <20171127195021.GO983427@devbig577.frc2.facebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 11:57:41AM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Use pci_get_domain_bus_and_slot() and extract the actual domain number
> from the pdev passed in.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route with the rest of the series.

Thanks.

-- 
tejun
