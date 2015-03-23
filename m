From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 23 Mar 2015 12:31:37 +0100
Subject: ATSAMA5D big endian work
In-Reply-To: <550C58F8.8080302@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <20150318183040.GT4560@piout.net> <550A9833.2080408@codethink.co.uk>
 <20150319133050.GD4750@piout.net> <550C51BF.6030501@codethink.co.uk>
 <20150320171940.GE20930@piout.net> <550C58F8.8080302@codethink.co.uk>
Message-ID: <550FF999.7030100@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/03/2015 18:29, Ben Dooks a ?crit :
> On 20/03/15 17:19, Alexandre Belloni wrote:
>> Hi,
>>
>> On 20/03/2015 at 16:58:39 +0000, Ben Dooks wrote :
>>>> You can use this branch until Nicolas merges my patches:
>>>>
>>>> https://github.com/alexandrebelloni/linux/tree/at91_4.1_04_cleanup2
>>>>
>>>> The remaining __raw_writel and __raw_readl are in pm.h
>>>
>>> Ok, should I submit my next series for inclusion in to your tree?
>>>
>>
>> I've sent all my series and Nicolas is supposed to take them soon so I
>> think the best would be to wait a bit. IF you want, I'll ping you when
>> everything is in.
> 
> Ok, I'll try and re-base on and test with your series in prep.

Ben, Alex,

I've just updated my branch at91-next that stands on my git tree
(https://git.kernel.org/cgit/linux/kernel/git/nferre/linux-at91.git/).

It includes at91-cleanup3 + at91-multiplatform + at91-cleanup4 that are
not yet included in arm-soc (nor linux-next).

So, you can start from this if you want to rebase your work. In the
meantime, we can continue to push obvious changes to subsystem
maintainers and think about Ben Hutchings' idea...

Thanks a lot, bye.
-- 
Nicolas Ferre
