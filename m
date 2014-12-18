From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Dec 2014 00:25:17 +0100
Subject: [PATCH v3 0/2] arm: pcibios: remove pci_sys_data domain
In-Reply-To: <54935F7A.7000206@ti.com>
References: <1416569367-29409-1-git-send-email-lorenzo.pieralisi@arm.com>
 <54935F7A.7000206@ti.com>
Message-ID: <14802556.IUBqXXJ43p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 December 2014 18:12:58 Murali Karicheri wrote:
> 
> I am assuming this is transparent to the user drivers of designware core 
> such as pci-keystone as CONFIG_PCI_DOMAINS_GENERIC is enabled by default 
> by ARM. Is this true ?

One difference is that you can now specify the domain number in DT,
but if you don't do that, it should behave exactly as befor.

	Arnd
