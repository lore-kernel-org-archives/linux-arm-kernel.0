From: davem@davemloft.net (David Miller)
Date: Tue, 19 Dec 2017 09:53:36 -0500 (EST)
Subject: [PATCH V4 14/26] pch_gbe: deprecate pci_get_bus_and_slot()
In-Reply-To: <ef7d09ce-06af-ad3e-1048-3b413cc32e9b@codeaurora.org>
References: <1513661883-28662-15-git-send-email-okaya@codeaurora.org>
 <1513680330.7000.167.camel@linux.intel.com>
 <ef7d09ce-06af-ad3e-1048-3b413cc32e9b@codeaurora.org>
Message-ID: <20171219.095336.2222430428460536576.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Tue, 19 Dec 2017 07:17:41 -0500

> Then hard code the domain number as 0 while calling
> pci_get_domain_bus_and_slot() if you know for sure that this device
> will never work on a non-zero domain.

Agreed, it's so much better to be explicit about this.
