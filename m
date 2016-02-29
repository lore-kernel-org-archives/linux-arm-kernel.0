From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Mon, 29 Feb 2016 19:42:58 +0200
Subject: [RFC PATCH] arm: kernel: pci: remove pci=firmware command line
 parameter handling
In-Reply-To: <1456767800-6609-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1456767800-6609-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20160229174258.GL5891@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 05:43:20PM +0000, Lorenzo Pieralisi wrote:

> According to kernel documentation, the pci=firmware command line
> parameter is only meant to be used on IXP2000 ARM platforms to prevent
> the kernel from assigning PCI resources configured by the bootloader.
> 
> Since the IXP2000 ARM platforms support has been removed from the
> kernel in commit:
> 
> commit c65f2abf54a6 ("ARM: remove ixp23xx and ixp2000 platforms")
> 
> its platforms specific kernel parameters should be removed
> too from the kernel documentation along with the kernel code
> currently handling them in that they have just become obsolete.
> 
> This patch removes the pci=firmware command line parameter handling
> from ARM code and the related kernel parameters documentation
> section.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Lennert Buytenhek <kernel@wantstofly.org>
