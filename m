From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 23:09:16 +0200
Subject: [PATCH] PCI: generic: Fix address window calculation for non-zero
 starting bus.
In-Reply-To: <1444334056-4870-1-git-send-email-ddaney.cavm@gmail.com>
References: <1444334056-4870-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <5232073.r65S9X2O3H@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 October 2015 12:54:16 David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Make the offset from the beginning of the "reg" property be from the
> starting bus number, rather than zero.  Hoist the invariant size
> calculation out of the mapping for loop.
> 
> Update host-generic-pci.txt to clarify the semantics of the "reg"
> property with respect to non-zero starting bus numbers.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> 

Thanks a lot!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
