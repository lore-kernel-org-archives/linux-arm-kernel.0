From: gengdj.1984@gmail.com (gengdongjiu)
Date: Fri, 10 Aug 2018 06:16:45 +0800
Subject: [PATCH RESEND v2] arm64: clean the additional checks before
 calling ghes_notify_sea()
In-Reply-To: <CABo9ajBKEWmgh6tBbUnrY8zM3vAH+TKWwBHn-Vz556Up+614Zw@mail.gmail.com>
References: <1533659175-47076-1-git-send-email-gengdongjiu@huawei.com>
 <CAMj-D2Arv-ZxUMTB_zKKy58CghWsZJbTOcNdiD3KVzxJ-v973g@mail.gmail.com>
 <CABo9ajBKEWmgh6tBbUnrY8zM3vAH+TKWwBHn-Vz556Up+614Zw@mail.gmail.com>
Message-ID: <CAMj-D2De_LzxMjNT_w-N2iiqBYq4wbdY6vEvjxr5yaAuhBg+jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-08-10 5:05 GMT+08:00 Tyler Baicar <baicar.tyler@gmail.com>:
> On Thu, Aug 9, 2018 at 8:32 AM, gengdongjiu <gengdj.1984@gmail.com> wrote:
>>
>> 2018-08-08 0:26 GMT+08:00 Dongjiu Geng <gengdongjiu@huawei.com>:
>> > In order to remove the additional check before calling the
>> > ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.
>> >
>> > After this cleanup, we can simply call the ghes_notify_sea() to let
>> > APEI driver handle the SEA notification.
>> >
>> > CC: Tyler Baicar <tbaicar@codeaurora.org>
>> > CC: James Morse <james.morse@arm.com>
>> > Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> > Acked-by: Will Deacon <will.deacon@arm.com>
>> > ---
>> > This cleanup is ever mentioned by Mark Rutland in [1]
>> >
>> > [1]:
>> > https://lkml.org/lkml/2018/5/31/289
>> >
>
> FWIW - Looks good to me!

Thanks very much for this comments and review,
whether I can get your "Acked-by" or "Reviewed-by"? thanks

>
> Thanks,
> Tyler
