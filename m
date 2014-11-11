From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 11 Nov 2014 16:27:38 +0000
Subject: [PATCH 00/15] arm64: PCI/MSI: GICv3 ITS support (stacked domain
 edition)
In-Reply-To: <546234FA.3060501@linux.intel.com>
References: <1415720893-13371-1-git-send-email-marc.zyngier@arm.com>
 <546234FA.3060501@linux.intel.com>
Message-ID: <546238FA.3040307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/14 16:10, Jiang Liu wrote:
> Hi Marc,
> 	Sorry for the late notification. I have heavily reworked the
> interfaces for MSI irqdomain support based on review comments.
> Please refer to https://lkml.org/lkml/2014/11/9/88, please give your
> comments on the new interfaces:)

Ah, I feel like I have more catch-up to do. Hopefully the changes are
simple enough to implement. Rebase time...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
