From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Feb 2014 14:22:39 +0100
Subject: [PATCH v2 3/4] pci: Introduce a domain number for pci_host_bridge.
In-Reply-To: <1393506402-11474-4-git-send-email-Liviu.Dudau@arm.com>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com>
 <1393506402-11474-4-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <7263969.1aniqAkfKX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 13:06:41 Liviu Dudau wrote:
> Make it easier to discover the domain number of a bus by storing
> the number in pci_host_bridge for the root bus. Several architectures
> have their own way of storing this information, so it makes sense
> to try to unify the code. While at this, add a new function that
> creates a root bus in a given domain and make pci_create_root_bus()
> a wrapper around this function.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
