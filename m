From: adrian.wenl@gmail.com (Lei Wen)
Date: Mon, 19 Sep 2011 10:29:11 +0800
Subject: [PATCH] ARM: kdump: copy kernel relocation code at the kexec
	prepare stage
In-Reply-To: <CALZhoSQSOTxV_OKVWwrmUt2tVqo3STEwonZcdzY398MLbP9U9w@mail.gmail.com>
References: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
	<20110916054556.GA10298@verge.net.au>
	<CALZhoSQSOTxV_OKVWwrmUt2tVqo3STEwonZcdzY398MLbP9U9w@mail.gmail.com>
Message-ID: <CALZhoSSpx3e8JAb8JLdOoXXay_055XQ126SJLVyUPedUh9KAjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2011 at 9:58 PM, Lei Wen <adrian.wenl@gmail.com> wrote:
> Hi Simon,
>
> On Fri, Sep 16, 2011 at 1:45 PM, Simon Horman <horms@verge.net.au> wrote:
>> On Thu, Sep 15, 2011 at 10:32:09PM -0700, Lei Wen wrote:
>>> This copy really don't need to do at the very second before the kernel
>>> would crash.
>>>
>>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>>
>> This seems reasonable to me.
>>
>> Acked-by: Simon Horman <horms@verge.net.au>
>
> Thanks for acked. :)
>
> BTW, do you know which git tree should this patch be merged?
>

Push it to Russell's patch tracking system. :)

Best regards,
Lei
