From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 08 Jul 2013 10:58:14 +0100
Subject: v3.10 - big endian core support
In-Reply-To: <51DA5089.5080109@gmail.com>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
 <51DA5089.5080109@gmail.com>
Message-ID: <51DA8D36.7010006@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/13 06:39, jgq516 at gmail.com wrote:
> On 07/01/2013 07:03 PM, Ben Dooks wrote:
>> The latest big-endian changes, now on:
>>
>> git://git.baserock.org/delta/linux baserock/311/be/core
>>
>> This has a minor fix from the last version where a rebase missed a change
>> in the smp_scu code.
>>
> Hello Ben,
>
> Thanks for you patches at first. I can boot BE kernel on vexpress a15 tc2
> board with LPAE disabled.
>
> However if enable LPAE, kernel seems hang after turn on mmu on since
> printascii can't output any character in __mmap_switched.
> Did you happen to try BE kernel with LPAE enabled before? or am I missed
> something?

I thought I did try the vexpress with LPAE, however it may have been
with a previous revision of the patches.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
