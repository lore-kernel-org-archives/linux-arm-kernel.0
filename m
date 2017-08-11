From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 11 Aug 2017 11:43:43 +0200
Subject: [PATCH v2 2/6] edac: synopsys: Add platform specific structures
 for ddrc controller
In-Reply-To: <20170811092225.GE9432@nazgul.tnic>
References: <91fd6532076e4c905b5a228d852bba4941c54a28.1502091561.git.michal.simek@xilinx.com>
 <6c72eae7c1fbfd2b96d5dc1c7feb251bdbe3e591.1502091561.git.michal.simek@xilinx.com>
 <20170811090926.GC9432@nazgul.tnic>
 <9800a639-2e1b-5008-14fc-b2135a27f826@xilinx.com>
 <20170811092225.GE9432@nazgul.tnic>
Message-ID: <c0fe2afe-75da-a18f-735f-d2c82e4a070b@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.8.2017 11:22, Borislav Petkov wrote:
> On Fri, Aug 11, 2017 at 11:16:15AM +0200, Michal Simek wrote:
>> https://lkml.org/lkml/2017/8/7/105
>> ACK by Rob yesterday.
> 
> Ok, pls bounce it to me as I don't have it.

ok.

> 
> Also, pls refrain from using lkml.org. Simply do:
> 
> http://lkml.kernel.org/r/<Message-ID>

Interesting. I have never seen this before.

http://lkml.kernel.org/r/91fd6532076e4c905b5a228d852bba4941c54a28.1502091561.git.michal.simek at xilinx.com

> 
>> I am using patman - u-boot tools for sending patch. It read MAINTAINERS
>> file and copy right people.
>> It has option to explicitly CC people. I need to resend this as v3
>> anyway that's why I will add you there.
> 
> Yes, if you send cross-maintainer changes, please make sure to CC them on all
> patches because otherwise stuff like that happens and people start wondering
> where is the rest and so on.

ok. Anyway do you see something else what I should fix in v3?

Thanks,
Michal
