From: shijie8@gmail.com (Huang Shijie)
Date: Sat, 11 Aug 2012 09:56:37 -0400
Subject: [PATCH v3] mtd: gpmi: add NAND write verify support
In-Reply-To: <201208111447.18076.marex@denx.de>
References: <1344700231-12624-1-git-send-email-shijie8@gmail.com>
 <201208110913.54479.marex@denx.de>
 <CAMiH66GbOYDpo-RDUct2nCixaf+9vhmT8Ouz+YPx95Z1+g2B1Q@mail.gmail.com>
 <201208111447.18076.marex@denx.de>
Message-ID: <CAMiH66E+a=8cxj5wFwNVHRJ5DReEVQ0uwr5MBmdM6HqThbrbOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 8:47 AM, Marek Vasut <marex@denx.de> wrote:
> Dear Huang Shijie,
>
>> On Sat, Aug 11, 2012 at 3:13 PM, Marek Vasut <marex@denx.de> wrote:
>> > Dear Huang Shijie,
>> >
>> > Please re-add credit to Fabio. Also, Fabio fixed the subject to be more
>>
>> sorry. Should I add "Reported by : Fabio ...." to the patch?
>
> Yes, at least.
>
>> I really appriaciate Fabio's work, but I do not think Fabio's patch is
>> more accurate.
>> The nand chips can be 2K page, 4K page and 8K page. But most of the
>> time, the nand chip is 4K page.
>> If we fix the verify_buf to 8K size as Fabio's patch does. It will
>> waste much memory.
>> This is my concern now. :)
>
> That's all right, but the rest of your patch is Fabio's work, correct me if I'm

Frankly speaking, this patch was finished after I read your comments,
and before Fabio sent out his patch.
I did not send it out, just because i did not test it on the imx6q-arm2 board.

thanks

Huang Shijie
