From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 5 Dec 2016 10:52:53 +0000
Subject: next-20161205 build: 3 failures 4 warnings (next-20161205)
In-Reply-To: <20161205104455.2m5ky3hgd5n2kb2w@sirena.org.uk>
References: <E1cDo86-0008IX-9W@optimist>
 <20161205104455.2m5ky3hgd5n2kb2w@sirena.org.uk>
Message-ID: <b8c4cce8-c114-b576-c073-7d14fd79f0f0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/16 10:44, Mark Brown wrote:
> On Mon, Dec 05, 2016 at 07:56:06AM +0000, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an arm64 allmodconfig:  
> 
>> 	arm64-allmodconfig
>> ../arch/arm64/include/asm/probes.h:18:25: fatal error: asm/opcodes.h: No such file or directory
> 
> due to bca8f17f57bd76d (arm64: Get rid of asm/opcodes.h) having missed
> one reference to the header.

Fix on the list: https://www.spinics.net/lists/arm-kernel/msg546960.html

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
