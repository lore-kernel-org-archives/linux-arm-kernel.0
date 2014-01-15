From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 15 Jan 2014 10:01:09 -0800
Subject: [RFC 0/2] Early patches to get rid of meminfo
In-Reply-To: <20140115135020.GJ30907@bivouac.eciton.net>
References: <1389765322-28582-1-git-send-email-lauraa@codeaurora.org>
 <20140115135020.GJ30907@bivouac.eciton.net>
Message-ID: <52D6CCE5.4010104@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/15/2014 5:50 AM, Leif Lindholm wrote:
> Hi Laura,
>
> On Tue, Jan 14, 2014 at 09:55:20PM -0800, Laura Abbott wrote:
>> With the move away from bootmem and the convergence on memblock, it seems
>> like meminfo should be deprecated as well to avoid duplication. This is
>> a first pass attempt to just use memblock and not have meminfo integrated.
>> There is still a major issue in terms of actually specifying mem at location
>> on the command line but I wanted to send this out for some early feedback
>> before putting any more effort into this. I've done basic boot testing on
>> a simple DT target.
>
> I can't see 1/2 and 2/2 - either in my inbox or in the archive.
> Could you resend?
>
> /
>      Leif


The patches are being held for moderation because apparently they have 
"a suspicious header". Not sure how the cover letter made it through but 
the patches didn't. If they don't get approved by end of the day I'll 
try re-sending.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
