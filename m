From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 Apr 2010 09:10:13 +1000
Subject: [PATCH] ARM: Add support for PCI domains
In-Reply-To: <20100414155503.GD21526@n2100.arm.linux.org.uk>
References: <20100330191442.GA13557@oksana.dev.rtsoft.ru>
	<20100414155503.GD21526@n2100.arm.linux.org.uk>
Message-ID: <20100415231013.GK12674@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 14, 2010 at 04:55:03PM +0100, Russell King - ARM Linux wrote:
> On Tue, Mar 30, 2010 at 11:14:42PM +0400, Anton Vorontsov wrote:
> > This patch adds support for PCI domains on ARM platforms.
> > 
> > Also, protect asm/mach/pci.h from multiple inclustions, otherwise
> > build fails because of pci_domain_nr() and pci_proc_domain()
> > redefinitions.
> 
> Ok.

Hi Russell,

what if anything needs to be done to merge this change?
