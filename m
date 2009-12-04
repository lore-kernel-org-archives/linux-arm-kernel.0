From: hs@denx.de (Heiko Schocher)
Date: Fri, 04 Dec 2009 20:33:37 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <alpine.LFD.2.00.0912041254220.31174@xanadu.home>
References: <4B18F141.7070101@denx.de>
	<alpine.LFD.2.00.0912041222040.31174@xanadu.home>
	<4B194B39.50301@denx.de>
	<alpine.LFD.2.00.0912041254220.31174@xanadu.home>
Message-ID: <4B196411.2020709@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas Pitre,

Nicolas Pitre wrote:
> On Fri, 4 Dec 2009, Heiko Schocher wrote:
> 
>> Hello Nicolas Pitre,
>>
>> Nicolas Pitre wrote:
>>> On Fri, 4 Dec 2009, Heiko Schocher wrote:
>>>
>>>> Hello,
>>>>
>>>> I have the following shared mem problem on a ARM v5TE
>>>> processor using Linux version 2.6.28,
>>> Could you apply this patch and test again:
>>>
>>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=08e445bd6a
>> Thanks for your reply. I applied this patch, but it didn;t help.
> 
> OK. Then could you test with Linux version 2.6.32, just to be sure the 
> issue still exists there?

I try to start a 2.6.32 kernel, but maybe I need some time for it.

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
