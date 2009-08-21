From: bgat@billgatliff.com (Bill Gatliff)
Date: Fri, 21 Aug 2009 10:32:14 -0500
Subject: i.MX35 Kernel without ARM EABI support  cannot execute init
In-Reply-To: <20090821161240.GA20522@flaco.tsc-farm.upc.es>
References: <1250865435.17931.20.camel@wks02-lin.nanotronic.local>
	<20090821161240.GA20522@flaco.tsc-farm.upc.es>
Message-ID: <4A8EBDFE.7010908@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hector Oron wrote:
> Hello,
>
> On Fri, Aug 21, 2009 at 04:37:15PM +0200, hoefle marco wrote:
>   
>> When trying to boot the i.MX35 Kernel (with ARM EABI or without, the
>> kernel panic remains exactly the same) using the emdebian rootfs I get
>> this:
>>
>> Kernel panic - not syncing: Attempted to kill init!
>> Has anybody an idea why this is not working?
>>     

I've seen something like this when the .config doesn't include a FP 
emulation selection.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
