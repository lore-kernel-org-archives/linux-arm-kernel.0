From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 28 Apr 2012 17:22:21 +0200
Subject: [PATCH 6/8] ARM: PCI: provide a default bus scan implementation
In-Reply-To: <E1SNLmX-000817-1y@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Thu, 26 Apr 2012 11:18:37 +0100")
References: <20120426101626.GE24211@n2100.arm.linux.org.uk>
 <E1SNLmX-000817-1y@rmk-PC.arm.linux.org.uk>
Message-ID: <m3zk9v7ufm.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> Most PCI implementations perform simple root bus scanning.  Rather than
> having each group of platforms provide a duplicated bus scan function,
> provide the PCI configuration ops structure via the hw_pci structure,
> and call the root bus scanning function from core ARM PCI code.

Acked-by: Krzysztof Ha?asa <khc@pm.waw.pl>
