From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 12 Nov 2014 00:32:16 +0800
Subject: [PATCH 00/15] arm64: PCI/MSI: GICv3 ITS support (stacked domain
 edition)
In-Reply-To: <546238FA.3040307@arm.com>
References: <1415720893-13371-1-git-send-email-marc.zyngier@arm.com>
 <546234FA.3060501@linux.intel.com> <546238FA.3040307@arm.com>
Message-ID: <54623A10.9030705@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/12 0:27, Marc Zyngier wrote:
> On 11/11/14 16:10, Jiang Liu wrote:
>> Hi Marc,
>> 	Sorry for the late notification. I have heavily reworked the
>> interfaces for MSI irqdomain support based on review comments.
>> Please refer to https://lkml.org/lkml/2014/11/9/88, please give your
>> comments on the new interfaces:)
> 
> Ah, I feel like I have more catch-up to do. Hopefully the changes are
> simple enough to implement. Rebase time...
The new interfaces are still RFC, so comments are warmly welcomed!
Regards!
Gerry
> 
> Thanks,
> 
> 	M.
> 
