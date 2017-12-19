From: davem@davemloft.net (David Miller)
Date: Tue, 19 Dec 2017 09:13:56 -0500 (EST)
Subject: [PATCH V4 20/26] openprom: deprecate pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-21-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-21-git-send-email-okaya@codeaurora.org>
Message-ID: <20171219.091356.821622473544969175.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Tue, 19 Dec 2017 00:37:56 -0500

> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Hard-coding the domain as 0 since domain information is not available.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Acked-by: David S. Miller <davem@davemloft.net>
