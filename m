From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 11 Aug 2017 11:16:15 +0200
Subject: [PATCH v2 2/6] edac: synopsys: Add platform specific structures
 for ddrc controller
In-Reply-To: <20170811090926.GC9432@nazgul.tnic>
References: <91fd6532076e4c905b5a228d852bba4941c54a28.1502091561.git.michal.simek@xilinx.com>
 <6c72eae7c1fbfd2b96d5dc1c7feb251bdbe3e591.1502091561.git.michal.simek@xilinx.com>
 <20170811090926.GC9432@nazgul.tnic>
Message-ID: <9800a639-2e1b-5008-14fc-b2135a27f826@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.8.2017 11:09, Borislav Petkov wrote:
> On Mon, Aug 07, 2017 at 09:39:24AM +0200, Michal Simek wrote:
>> From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
>>
>> Adds platform specific structures, so that we can add
>> different IP support later using quirks.
>>
>> Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2:
> 
> Subject says "2/6" but I can't find 1/6 in my mbox. Nothing in spam
> folder either. What's up?

https://lkml.org/lkml/2017/8/7/105
ACK by Rob yesterday.

> 
> Are you using the --cover-letter option to git format-patch ?

I am using patman - u-boot tools for sending patch. It read MAINTAINERS
file and copy right people.
It has option to explicitly CC people. I need to resend this as v3
anyway that's why I will add you there.

Thanks,
Michal
