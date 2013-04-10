From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 10 Apr 2013 10:09:03 -0300
Subject: [PATCHv1 0/5] Marvell EBU irqchip improvements
In-Reply-To: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130410130902.GA29100@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, Apr 09, 2013 at 11:26:13PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> Here is a set of 5 patches that move the Marvell EBU IRQ controller
> driver to drivers/irqchip/ and do a few minor related cleanup or
> improvements.
> 
> Those commits were originally part of the series introducing PCIe MSI
> support for Marvell EBU platform, but the MSI support is not ready for
> merging. However, I'd like those preparation patches to be considered
> for 3.10.
> 

I'm trying to test this patchset, assuming you've based it on top of
v3.9-rc5.

However, patch 4/5 doesn't apply and I'm not really sure which
other patches may be depending on this.

Any hints?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
