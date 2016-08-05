From: ddaney@caviumnetworks.com (David Daney)
Date: Fri, 5 Aug 2016 09:37:39 -0700
Subject: [PATCH] arm64: Add workaround for Cavium erratum 26026
In-Reply-To: <20160805070030.GQ22012@rric.localdomain>
References: <1470302117-32296-1-git-send-email-mbrugger@suse.com>
 <20160804205707.GJ2151@rric.localdomain> <57A3B660.4040309@gmail.com>
 <20160805070030.GQ22012@rric.localdomain>
Message-ID: <57A4C0D3.2060408@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2016 12:00 AM, Robert Richter wrote:
> On 04.08.16 14:40:48, David Daney wrote:
>> On 08/04/2016 01:57 PM, Robert Richter wrote:
>>> The patch below is on top of Matthias' patch series:
>>>
>>>   arm64: Implement IPI based TLB invalidation
>>>
>>> The series is used to enable a workaround for Cavium ThunderX pass 1.x
>>> systems.
>>
>>
>> Where are the rest of the patches in the series?  I would have expected
>> something like "[PATCH 1/X] arm64:..." with X being greater than one.
>
> You are cc'ed here too:
>
>   https://lkml.org/lkml/2016/8/4/101
>

OK, I got confused by the fact that this patch was retroactively added 
to the patch set and was missing the sequence numbering.

> -Robert
>
