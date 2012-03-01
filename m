From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Feb 2012 21:53:40 -0600
Subject: [PATCH 7/8] ARM: OMAP: Remove plat/io.h by moving it into
 mach/io.h
In-Reply-To: <20120301034613.GW18901@atomide.com>
References: <4F4451FB.7070007@gmail.com> <20120224000657.GJ18185@atomide.com>
 <20120224182246.GL18185@atomide.com> <4F4AFCC7.3020509@gmail.com>
 <20120229014719.GK18901@atomide.com> <4F4EBBDF.9090806@gmail.com>
 <20120301001140.GA18438@n2100.arm.linux.org.uk>
 <20120301003939.GU18901@atomide.com> <20120301010348.GV18901@atomide.com>
 <4F4EEE30.9080109@gmail.com> <20120301034613.GW18901@atomide.com>
Message-ID: <4F4EF2C4.2060605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29/2012 09:46 PM, Tony Lindgren wrote:
> * Rob Herring <robherring2@gmail.com> [120229 19:02]:
>> On 02/29/2012 07:03 PM, Tony Lindgren wrote:
>>>
>>> Rob, I assume you'll apply this into your branch?
>>>
>>
>> Yes
> 
> OK
>  
>>> --- a/arch/arm/plat-omap/include/plat/sdrc.h
>>> +++ b/arch/arm/plat-omap/include/plat/sdrc.h
>>> @@ -16,8 +16,6 @@
>>>   * published by the Free Software Foundation.
>>>   */
>>>  
>>> -#include <mach/io.h>
>>> -
>>
>> I added iomap.h here as there are macros in the header from it.
> 
> Hmm, did you get some compile error? I though all code
> using sdrc.h already has iomap.h included. This file
> should eventually be local to mach-omap2.
> 

No, just examined the file. If it compiles, either way is fine with me.

Rob
