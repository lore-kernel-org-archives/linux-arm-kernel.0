From: dirk.behme@gmail.com (Dirk Behme)
Date: Sat, 18 Aug 2012 11:58:33 +0200
Subject: [PATCH] mtd: mxc_nand: Fix compiler warnings
In-Reply-To: <20120805083926.GL2626@pengutronix.de>
References: <1343466310-14584-1-git-send-email-dirk.behme@gmail.com>
 <20120730073454.GI1528@pengutronix.de> <501D4405.6030900@googlemail.com>
 <20120805083926.GL2626@pengutronix.de>
Message-ID: <502F6749.4020705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.08.2012 10:39, Uwe Kleine-K?nig wrote:
> On Sat, Aug 04, 2012 at 05:47:17PM +0200, Dirk Behme wrote:
>> On 30.07.2012 09:34, Uwe Kleine-K?nig wrote:
>>> Hello,
>>>
>>> On Sat, Jul 28, 2012 at 11:05:10AM +0200, Dirk Behme wrote:
>>>> From: Dirk Behme<dirk.behme@googlemail.com>
>>>>
>>>> Fix the compiler warnings
>>>>
>>>> drivers/mtd/nand/mxc_nand.c:1267: warning: initialization discards qualifiers from pointer target type
>>>> drivers/mtd/nand/mxc_nand.c:1270: warning: initialization discards qualifiers from pointer target type
>>>> drivers/mtd/nand/mxc_nand.c:1273: warning: initialization discards qualifiers from pointer target type
>>>> drivers/mtd/nand/mxc_nand.c:1276: warning: initialization discards qualifiers from pointer target type
>>> These should be gone in next already.
>>
>> Hmm, which next?
>>
>> I tried linux-next [1] from today (next-20120803, 55fa9961f) and still get
> next-20120725 contained 98d7bbb9929bcc14e11ac8a55245a4f2dc174e17, don't
> konw why it isn't included in the newer next snapshorts.

It seems to be in -next again:

http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commit;h=98d7bbb9929bcc14e11ac8a55245a4f2dc174e17

I'm not so familiar with -next: Do we have any chance to get that 
commit into 3.6-rcX to get this warning fixed for the final 3.6?

Best regards

Dirk
