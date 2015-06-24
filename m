From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 24 Jun 2015 14:30:05 +0100
Subject: [PATCH v3 06/10] arm: simplify MMIO dispatching
In-Reply-To: <55817EEA.9060402@arm.com>
References: <1434540121-21283-1-git-send-email-andre.przywara@arm.com>
 <1434540121-21283-7-git-send-email-andre.przywara@arm.com>
 <55816C9F.1090500@arm.com> <55817B07.8010502@arm.com>
 <55817EEA.9060402@arm.com>
Message-ID: <558AB0DD.1070704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

do you want me to respin the whole series to address the remaining minor
comments in the last four patches or do you want to take patch 01-06
already (which I think Marc has already agreed upon)?
Then I would just send an updated version of the remaining patches.

Cheers,
Andre.


....

> No, that's fine.
> 
> I just wondered what was the rational behind having the
> arm_addr_in_pci_region() call there. It might have guarded something,
> but if you're absolutely positive that this doesn't cause a regression,
> that's OK with me.
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> 	M.
> 
