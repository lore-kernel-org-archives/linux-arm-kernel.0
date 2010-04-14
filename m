From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Apr 2010 16:55:03 +0100
Subject: [PATCH] ARM: Add support for PCI domains
In-Reply-To: <20100330191442.GA13557@oksana.dev.rtsoft.ru>
References: <20100330191442.GA13557@oksana.dev.rtsoft.ru>
Message-ID: <20100414155503.GD21526@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 30, 2010 at 11:14:42PM +0400, Anton Vorontsov wrote:
> This patch adds support for PCI domains on ARM platforms.
> 
> Also, protect asm/mach/pci.h from multiple inclustions, otherwise
> build fails because of pci_domain_nr() and pci_proc_domain()
> redefinitions.

Ok.
