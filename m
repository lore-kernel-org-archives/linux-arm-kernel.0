From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 19 Mar 2013 17:43:49 +0100
Subject: [BUG][mvebu] mvneta: cannot request irq 25 on openblocks-ax3
In-Reply-To: <514873FB.5050202@hitachi.com>
References: <51486445.8040506@hitachi.com> <20130319133928.GE3137@localhost>
 <514873FB.5050202@hitachi.com>
Message-ID: <514895C5.40706@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2013 03:19 PM, Masami Hiramatsu wrote:
> Hi Ezequiel,
> 
> (2013/03/19 22:39), Ezequiel Garcia wrote:
>> Hi Masami,
>>
>> On Tue, Mar 19, 2013 at 10:12:37PM +0900, Masami Hiramatsu wrote:
>>>
>>> Here I've hit a bug on the recent kernel. As far as I know, this bug
>>> exists on 3.9-rc1 too.
>>>
>>> When I tried the latest mvebu for-next tree
>>> (git://git.infradead.org/users/jcooper/linux.git mvebu/for-next),
>>> I got below warning at bootup time and mvneta didn't work (link was never up).
>>> I ensured that "ifconfig ethX up" always caused that.
>>>
>>> Does anyone succeed to boot openblocks-ax3 recently or hit same
>>> trouble?
>>
>> This is a known bug. Gregory Clement already has a fix and he
>> will submit it soon. In case you need this fixed ASAP, I'm attaching
>> you a patch with a fix.
> 
> Thanks! I'll try that.
> 
>> Please note the attached patch is not ready for mainline inclusion,
>> as I said Gregory will submit a cleaner version soon.
> 
> Yeah, I look forward to it :)

Hi Masami,

You can try this patch if you want.
I don't have the hardware today so I didn't test it.
If you (and also Florian and Ezequiel) can test it and if it fixed
the bug, then I will be able send a proper email for it,

Thanks,
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-net-mvneta-convert-to-local-interrupt.patch
Type: text/x-diff
Size: 3140 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130319/46ad8983/attachment.bin>
