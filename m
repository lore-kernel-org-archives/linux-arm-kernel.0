From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 4 Aug 2017 09:49:33 +0200
Subject: [PATCH 2/2] char: xilinx_hwicap: Fix warnings in the driver
In-Reply-To: <20170803223218.ilryp5spqztsr3cz@rob-hp-laptop>
References: <6da0afe2afd2c7a21d16da9a9c7acab09385ae2c.1501247838.git.michal.simek@xilinx.com>
 <79e2e616a8b7dbf38eb72ba0b620230017dcbc65.1501247838.git.michal.simek@xilinx.com>
 <20170803223218.ilryp5spqztsr3cz@rob-hp-laptop>
Message-ID: <0e40a687-e11b-b5bb-24f0-465144c98929@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4.8.2017 00:32, Rob Herring wrote:
> On Fri, Jul 28, 2017 at 03:17:26PM +0200, Michal Simek wrote:
>> From: Nava kishore Manne <nava.manne@xilinx.com>
>>
>> This patch fixes the below warning
>>         --> Use #include <linux/io.h> instead of <asm/io.h>
>>         --> Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
>>         --> please, no space before tabs
>>         --> Block comments use a trailing */ on a separate line
>>         --> Possible unnecessary 'out of memory' message
>>         --> Block comments use * on subsequent lines
>>         --> Block comments use a trailing */ on a separate line
>>         --> braces {} are not necessary for any arm of this statement
>>         --> DT compatible string "xlnx,opb-hwicap-1.00.b"
>> 	    appears un-documented
>>         --> DT compatible string "xlnx,xps-hwicap-1.00.a"
>>             appears un-documented
>>
>> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  Documentation/devicetree/bindings/xilinx.txt |  2 ++
> 
> It's preferred to split bindings to separate patches. No need unless you 
> respin:
> 
> Acked-by: Rob Herring <robh@kernel.org>

thanks. Was there any outcome from that discussion to extract binding
out of kernel source code?

Thanks,
Michal
