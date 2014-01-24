From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Fri, 24 Jan 2014 10:43:11 -0500
Subject: [PATCH] arm64: delete non-required instances of <linux/init.h>
In-Reply-To: <20140124152308.GE19052@arm.com>
References: <1390501611-31691-1-git-send-email-paul.gortmaker@windriver.com>
 <20140124152308.GE19052@arm.com>
Message-ID: <52E28A0F.8020104@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-01-24 10:23 AM, Catalin Marinas wrote:
> On Thu, Jan 23, 2014 at 06:26:51PM +0000, Paul Gortmaker wrote:
>> None of these files are actually using any __init type directives
>> and hence don't need to include <linux/init.h>.  Most are just a
>> left over from __devinit and __cpuinit removal, or simply due to
>> code getting copied from one place to the next.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>
>> [Build tested on today's linux-next ; thanks to Will for the pointer
>>  to a prebuilt toolchain.  Patch to be added to init cleanup series:
>>    http://git.kernel.org/cgit/linux/kernel/git/paulg/init.git   ]
> 
> I assume you are pushing this upstream as part of your cleanup series.

Yes, that is the plan -- ack added, thanks.

P.
--

> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
