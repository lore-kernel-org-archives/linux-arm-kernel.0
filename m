From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 15 Nov 2012 20:24:49 +0800
Subject: [PATCH] ARM: pxa: remove pxa95x support
In-Reply-To: <201211151214.47073.arnd@arndb.de>
References: <1352970366-7154-1-git-send-email-haojian.zhuang@gmail.com>
 <201211151206.33461.arnd@arndb.de>
 <201211151214.47073.arnd@arndb.de>
Message-ID: <CAN1soZyfPT7pJjyO_vxGGhzC5hB_5XX1DAR2VwDP9XtH29FV8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 8:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 15 November 2012, Arnd Bergmann wrote:
>> On Thursday 15 November 2012, Haojian Zhuang wrote:
>> > PXA95x isn't widely used. And it adds the effort on supporting
>> > multiple platform. So remove it.
>> >
>> > Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>>
>> Looks good to me, thanks for going through this.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Should I apply this straight into the arm-soc tree, or are you
>> going to send a pull request?
>>
>
> One more comment: It would be good to put a disclaimer into the
> changeset text like
>
>  "The assumption is that nobody will miss this support. If you are
>   reading this text because you actually require pxa95x support on
>   a new kernel, we can work out a way to revert this patch or add
>   support to the mmp platform".
>
>         Arnd

Yes, it's great. Please help to paste it into the changeset.

Best Regards
Haojian
